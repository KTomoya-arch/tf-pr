locals {
  func_src_path = "../../../func"
}

locals {
  env_strs = {
    abbrev = "dev"
    formal = "development"
  }
}

locals {
  regions = {
    us             = "us"
    asia           = "asia"
    south_carolina = "us-east1"
    tokyo          = "asia-northeast1"
  }
}

locals {
  host_project = "worx-${local.env_strs["abbrev"]}"

  service_projects = {
    engine   = "worx-engine-${local.env_strs["abbrev"]}"
    labor    = "worx-labor-${local.env_strs["abbrev"]}"
    personal = "worx-personal-${local.env_strs["abbrev"]}"
    mynumber = "worx-mynumber-${local.env_strs["abbrev"]}"
  }
}

locals {
  domain_strs = {
    worx             = "${local.env_strs["abbrev"]}.worx-hr.com"
    nalysys          = "${local.env_strs["abbrev"]}.nalysys.jp"
    internal_nalysys = "internal.nalysys.jp"
  }
}

locals {
  domain_bff_engine = {
    worx    = "engine.${local.domain_strs["worx"]}"
    nalysys = "engine.${local.domain_strs["nalysys"]}"
  }

  domain_bff_personal = {
    worx    = "personal.${local.domain_strs["worx"]}"
    nalysys = "personal.${local.domain_strs["nalysys"]}"
  }

  domain_bff_labor = {
    worx    = "labor.${local.domain_strs["worx"]}"
    nalysys = "labor.${local.domain_strs["nalysys"]}"
  }

  domain_bff_mynumber = {
    worx    = "mynumber.${local.domain_strs["worx"]}"
    nalysys = "mynumber.${local.domain_strs["nalysys"]}"
  }
}

locals {
  domain_api_bff_engine = {
    worx = {
      ssl_cert = "worx"
      domain   = "api.${local.domain_bff_engine["worx"]}"
    }

    nalysys = {
      ssl_cert = "nalysys"
      domain   = "api.${local.domain_bff_engine["nalysys"]}"
    }
  }

  domain_api_bff_personal = {
    worx = {
      ssl_cert = "worx"
      domain   = "api.${local.domain_bff_personal["worx"]}"
    }

    nalysys = {
      ssl_cert = "nalysys"
      domain   = "api.${local.domain_bff_personal["nalysys"]}"
    }
  }

  domain_api_bff_labor = {
    worx = {
      ssl_cert = "worx"
      domain   = "api.${local.domain_bff_labor["worx"]}"
    }

    nalysys = {
      ssl_cert = "nalysys"
      domain   = "api.${local.domain_bff_labor["nalysys"]}"
    }
  }

  domain_api_bff_mynumber = {
    worx = {
      ssl_cert = "worx"
      domain   = "api.${local.domain_bff_mynumber["worx"]}"
    }

    nalysys = {
      ssl_cert = "nalysys"
      domain   = "api.${local.domain_bff_mynumber["nalysys"]}"
    }
  }
}

locals {
  domain_be_account = {
    worx    = "account.${local.domain_strs["worx"]}"
    nalysys = "account.${local.domain_strs["nalysys"]}"
  }

  domain_be_storage = {
    worx    = "storage.${local.domain_strs["worx"]}"
    nalysys = "storage.${local.domain_strs["nalysys"]}"
  }

  domain_be_survey = {
    worx    = "survey.${local.domain_strs["worx"]}"
    nalysys = "survey.${local.domain_strs["nalysys"]}"
  }

  domain_be_service = {
    worx    = "service.${local.domain_strs["worx"]}"
    nalysys = "service.${local.domain_strs["nalysys"]}"
  }

  domain_service_be_auth = {
    worx    = "auth.${local.domain_be_service["worx"]}"
    nalysys = "auth.${local.domain_be_service["nalysys"]}"
  }

  domain_service_be_account = {
    worx    = "account.${local.domain_be_service["worx"]}"
    nalysys = "account.${local.domain_be_service["nalysys"]}"
  }

  domain_service_be_survey = {
    worx    = "survey.${local.domain_be_service["worx"]}"
    nalysys = "survey.${local.domain_be_service["nalysys"]}"
  }

  domain_be_internal = {
    db    = "db.${local.domain_strs["internal_nalysys"]}"
    redis = "redis.${local.domain_strs["internal_nalysys"]}"
  }
}
