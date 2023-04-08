# nalysys-terraform
## 1. ディレクトリ構成

```sh
nalysys-terraform
├── .github
├── .tfcmt
├── .tfnotify
├── README.md
├── docs
│   ├── drawio
│   └── pics
├── Dockerfile
├── docker-compose.yaml
├── bin
├── func
├── sql
└── src                    # TFファイル群
    ├── github-oidc        # GitHub OIDCのリソース (ローカルで反映)
    ├── basic-setups       # 基本設定のリソース (ローカルで反映)
    └── nalysys-infra      # NALYSYSのインフラ (CI/CDで反映)
```


## 2. インフラ構成図
### 2.1. 運用
`terraform import`を行った時，`docs/diagram/`で`drawio`のファイルを編集し，`pics`に`JPEG`形式で出力する．

### 2.2. 概要
![gcp-architecture-dev](./docs/pics/gcp-architecture.jpg)

このプロジェクトでは，現在はフロントエンド以外のインフラ構成を管理している．

CI/CDを用いたインフラ構築の前に，次の手動での作業を済ませておく必要がある．

1. `GCP`のプロジェクト・権限・共有ネットワーク等の設定
2. `src/basic-setups`での手動での`terraform apply`の実施
3. `Secrets`の値の手動での設定
4. `Cloud Functions`のソースコードの`GCS`へのアップロード
5. `Cloud Run`用のイメージの手動でのビルド・プッシュ


## 3. ローカル環境
### 3.1. 認証設定
次のコマンドを実行して，`GCP`のログインとアクセスクレデンシャルの作成を行う．

実行時に，ターミナルでURLが表示される．これをブラウザで開いて操作を行い，認証コードをコピーする．

コピーした認証コードをターミナルに貼り付けて，実行を続ける．

#### (1) GCPへのアカウントでのログイン
```sh
$ docker-compose run nalysys_infra gcloud auth login --no-launch-browser
```

#### (2) アクセスクレデンシャルの作成
```sh
$ docker-compose run nalysys_infra gcloud auth application-default login --no-launch-browser
```

#### (3) 認証設定の破棄 (例：退職時)
```sh
$ docker-compose run nalysys_infra gcloud auth revoke
$ docker-compose run nalysys_infra gcloud auth application-default revoke
```

### 3.2. 差分の確認・反映
まずは，(1)を対応し差分の確認を行う．意図せぬ差分があれば，差分解消を行う．

(1)の実行結果で差分に問題が無ければ，(2)を対応して差分をクラウドへ反映する．

ただし，`${env}`，`${target}`，`${grep_str}`は下表の通りである．

| 項目 | 値 |
|---|---|
| `${env}` | `dev`，`stg`，`prd`，`test`のどれか |
| `${target}` | `basic-setups`，`nalysys-infra`のどれか |
| `${grep_str}` | `リソース名`，`リソースアドレス`のどれか<br><br>- 例1：`google_cloudbuild_trigger`<br>- 例2：`google_cloudbuild_trigger.worx_be_account` |

#### 3.2.1. GitHub OIDCのリソース
##### (1) 差分の確認

```sh
$ docker-compose run nalysys_infra bash ./bin/plan_local.sh ${env}
```

##### (2) 差分の反映

```sh
$ docker-compose run nalysys_infra bash ./bin/apply_local.sh ${env}
```

#### 3.2.2. NALYSYSのインフラ
##### (1) 差分の確認
###### 全体的な差分確認

```sh
$ docker-compose run nalysys_infra bash ./bin/plan.sh ${env} ${target}
```

###### 部分的な差分確認

```sh
$ docker-compose run nalysys_infra bash ./bin/plan_partial.sh ${env} ${target} ${grep_str}
```

##### (2) 差分の反映

```sh
$ docker-compose run nalysys_infra bash ./bin/apply.sh ${env} ${target}
```

### 3.3. インポート対応
#### (1) 設定テンプレートの生成
ローカル環境では，`Terraformer`で設定テンプレートが生成出来る．

まずは，次のコマンドを実行して，ローカル環境のコンテナに入る．

```
$ docker-compose run nalysys_infra bash
```

そして，次の様なコマンドで`Terraform`のリソース設定を生成する．

```
＃ cd src/nalysys-infra/${env}/
＃ terraformer import google ${command_option_1} ${command_option_2} ... ${command_option_n}
```

CLIコマンドの整形方法の詳細については，[参考情報](#8-参考情報)を確認されたい．

#### (2) リソース設定のインポート
まずは，次のコマンドを実行して，ローカル環境のコンテナに入る．

```sh
$ docker-compose run nalysys_infra bash
```

そして，次の様なコマンドで`Terraform`のインポートを実行する．

```sh
＃ cd src/nalysys-infra/${env}/
＃ terraform init
＃ terraform import ${resource_type}.${resource_name} ${import_condition}
```

ここで，`${env}`，`${resource_type}`，`${resource_name}`，`${import_condition}`は下表の通りである．

| 項目 | 値 |
|---|---|
| `${env}` | `dev`，`stg`，`prd`，`test`のどれか |
| `${resource_type}` | リソースタイプ (詳細は，[参考情報](#8-参考情報)を確認されたい) |
| `${resource_name}` | リソースの名前 (詳細は，[参考情報](#8-参考情報)を確認されたい) |
| `${import_condition}` | インポートの条件 (詳細は，[参考情報](#8-参考情報)を確認されたい) |

インポート処理が正常に終わった後は，[差分の確認・反映](#32-差分の確認反映)を行う．

### 3.4. Lint

```sh
# auto format
$ docker-compose run nalysys_infra terraform fmt -list -recursive
```

## 4. CI/CD
### 4.1. トリガー
CI/CDのトリガー設定は，次の通りである．

| No | 種別 | 設定 |
|---|---|---|
| 1 | `各環境のCI` | 作業ブランチから`main`へのプルリクエストの作成・更新 |
| 2 | `開発・検証・試験の環境のCD` | 作業ブランチから`main`へのプルリクエストのマージ対応 |
| 3 | `本番環境のCD` | `main`でのリリースの作成 |

### 4.2. ワークフロー
#### (1) CIのジョブ：トリガー実行
CIのトリガー実行のジョブ構成は次の通りである．以下のジョブを環境毎に並列で実行する．

![github-actions-ci](./docs/pics/github-actions-ci.jpg)

| No | 処理 | 内容 | 
|---|---|---|
| 1 | `checkout` | `Git`のチェックアウト処理 |
| 2 | `merge into default branch` | `Git`のデフォルトブランチへのマージ |
| 3 | `authenticate to gcp` | クラウドインフラへの認証 |
| 4 | `set up tfcmt` | `tfcmt`のセットアップ |
| 5 | `set up terraform` | `Terraform`のセットアップ |
| 6 | `terraform plan` | 次の一連の処理の実施：<br><br>1. `Terraform`での差分一覧の洗い出し<br>2. `tfcmt`でのプルリクエストへの通知 |

#### (2) CIのジョブ：手動実行
CIの手動実行のジョブ構成は次の通りである．以下のジョブを環境毎に並列で実行する．

![github-actions-ci](./docs/pics/github-actions-ci-manual.jpg)

| No | 処理 | 内容 | 
|---|---|---|
| 1 | `checkout` | `Git`のチェックアウト処理 |
| 2 | `authenticate to gcp` | クラウドインフラへの認証 |
| 3 | `set up tfcmt` | `tfcmt`のセットアップ |
| 4 | `set up terraform` | `Terraform`のセットアップ |
| 5 | `terraform plan` | 次の一連の処理の実施：<br><br>1. `Terraform`での差分一覧の洗い出し<br>2. `tfcmt`でのプルリクエストへの通知 |

#### (3) CDのジョブ
CDのジョブ構成は次の通りである．以下のジョブを環境別で実行する．

![github-actions-cd](./docs/pics/github-actions-cd.jpg)

| No | 処理 | 内容 | 
|---|---|---|
| 1 | `checkout` | `Git`のチェックアウト処理 |
| 2 | `authenticate to gcp` | クラウドインフラへの認証 |
| 3 | `set up tfnotify` | `tfnotify`のセットアップ |
| 4 | `set up terraform` | `Terraform`のセットアップ |
| 5 | `terraform apply` | 次の一連の処理の実施：<br><br>1. `Terraform`でのインフラ反映<br>2. `tfnotify`での`Slack`への通知 |


## 5. Git運用
開発者・管理者で分けて，以下のフローで`Git`の運用を行う．

### 5.1. 開発者向け
1. ローカルで，`main`から作業ブランチを作り，作業ブランチで開発を行う
2. 開発の後は，`GitHub`で作業ブランチから`main`へのプルリクエストを作成する
3. プルリクエストに概要を記載し，CIの実行結果に問題が無いかどうかを確認する
4. 問題が無ければ，レビュワーに対してプルリクエストのレビューを依頼する

### 5.2. 管理者向け
#### (1) 開発・検証・試験の環境へのデプロイ
1. `GitHub`で，作業ブランチから`main`へのプルリクエストをレビューする
2. コード差分やCIの実行結果に問題が無ければ，マージ対応を行いCDを実行する

#### (2) 本番環境へのデプロイ
1. 本番環境への変更の反映に関するスケジュール調整を行う
2. [CIの手動実行](#6-ciの手動実行)に沿って，本番環境のCIを実行して差分を確認する
3. 問題が無ければ，`main`で[リリース作成](#7-リリース作成)を行ってCDを実行する


## 6. CIの手動実行
`GitHub`の[CIの手動実行のワークフロー](https://github.com/worx-hr/nalysys-terraform/actions/workflows/ci-manual.yml)の画面で，画面左側の`Run workflow`を開く．

下表に沿って設定を行い，問題が無ければ`Run workflow`を押してCIを実行する．

| No | 項目 | 内容 |
|---|---|---|
| 1 | `Use workflow from` | `main`が選択されていることを確認する<br>(`main`がデフォルトブランチのため，特に何もしない) |
| 2 | `env value` | `dev`，`stg`，`prd`，`test`のどれか |


## 7. リリース作成
`GitHub`リポジトリのページで`Releases`を押し，遷移先の画面で作成画面を開く．

作成画面では，下表を参考に選択・記入を行い，`Save draft`を押して下書き保存をする．

選択・記載の内容に問題が無ければ，`Publish release`を押してリリースを作成する．

| No | 項目 | 内容 |
|---|---|---|
| 1 | `Choose a tag` | `yyyymmdd_xx`の様な形式の文字列を記載する<br>(例：`20220927_00`，`20220927_01`，`20220927_10`) |
| 2 | `Target` | `main`が選択されていることを確認する<br>(`main`がデフォルトブランチのため，特に何もしない) |
| 3 | `Release title` | `Choose a tag`の値と同じ文字列を記載する |
| 4 | `Describe this release` | リリースの変更点を簡単に記入する |


## 8. 参考情報
- https://www.terraform.io/docs
- https://registry.terraform.io/providers/hashicorp/google/latest/docs
- https://github.com/GoogleCloudPlatform/terraformer
