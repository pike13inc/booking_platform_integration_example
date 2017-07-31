require 'httparty'
require 'active_support'
require 'active_support/core_ext/time'
require 'pp'
require_relative 'helpers'

ACCESS_TOKEN = ENV['FD_ACCESS_TOKEN'] || "mytoken_xxxxxxxxx"

# This must include the subdomain of the business on Pike13. This
# can be obtain by simply asking the user or by having them authenticate
# on "https://pike13.com" and then using the Account People resource
# to determine which businesses this user has access to.  For more info
# see https://developer.pike13.com/docs/api/v2#endpoint-account-people
#
# For the purposes of this example, we will assume the subdomain of the
# business has already been obtained.
HOST = ENV['FD_HOST'] || "https://somebusiness.pike13.com"
