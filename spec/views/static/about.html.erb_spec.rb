require 'spec_helper'

describe 'static/about.html.erb' do
  it 'exists' do
    render
    rendered.should contain("They're made out of... meat")
    rendered.should contain("Ugly bags of mostly water")
  end
end
