# frozen_string_literal: true

require 'sinatra'
require 'pony'

require_relative 'lib/kisiwebhooks'

RULES = Kisiwebhooks::Rules::Loader.from_yaml(File.read('rules.yml'))

post '/kisi' do
  json = JSON.parse(request.body.read)
  if rule_triggered?(RULES['unlocks'], json)
    logger.info "sending mail"
    Pony.mail(to: RULES['unlocks'].subscribers,
              subject: json['message'],
              body: '',
              via: :smtp,
              via_options: {
                address: 'localhost',
                port: '1025'
              })
  else
    logger.info "rule not triggered"
  end
end

private

def rule_triggered?(rule, json)
  rule.triggers.all? do |attr, trigger|
    trigger.triggered?(json[attr])
  end
end
