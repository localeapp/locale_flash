require 'spec_helper'

describe LocaleFlash::Config do
  let(:config) { LocaleFlash::Config }

  # Config follows a singleton concept, so ensure goes back to default
  # after for every spec.
  after { config.template = LocaleFlash::Config::DEFAULT_TEMPLATE }

  describe '#template and #template=' do
    it 'returns the default template when nothing is configured' do
      config.template.should eq LocaleFlash::Config::DEFAULT_TEMPLATE
    end

    it 'returns the configured template if available' do
      template = -> { render 'layouts/flash', type: type, message: message }
      config.template = template
      config.template.should eq template
    end
  end
end
