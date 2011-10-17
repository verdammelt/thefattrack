require 'spec_helper'

describe 'static page routing' do
  it "routes about" do
    get('about').should route_to 'static#about'
  end
end
