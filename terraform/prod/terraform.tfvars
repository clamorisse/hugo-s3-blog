# ---------------------------------------------------
#         VARIABLES FOR ALL .TF FILES
# ---------------------------------------------------

# AWS CONFIGURATION VARIABLES

aws-region           = "us-east-1"
profile-name         = "ocean-bvc"

# TERRAFORM REMOTE STATE CONFIGURATION VARIABLES

tfstate-bucket       = "tfstate_blog_infra"
object-name          = "terraform.tfstate"

// app specific variables for production - be careful

application-name    = "bvcblog-cotero" 
bucket-name         = "bvcblog.cotero.org"
env                 = "prod" 
