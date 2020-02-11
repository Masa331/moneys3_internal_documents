Gem::Specification.new do |spec|
  spec.name          = "moneys3_internal_documents"
  spec.version       = '0.0.1'
  spec.authors       = ["Premysl Donat"]
  spec.email         = ["pdonat@seznam.cz"]
  spec.summary       = "Library for creating MoneyS3 xml internal documents for import."
  spec.homepage      = "git@github.com:Masa331/moneys3_internal_documents.git"
  spec.license       = "MIT"
  spec.files         = ['lib/moneys3_internal_documents.rb']

  spec.add_dependency 'money_s3'
end
