require 'round'

describe 'Round' do
  include Round

  context '#round_for_display' do
    it 'rounds to 2 decimal places' do 
      round_for_display(3.14159).should == 3.14
    end

    it 'returns nil for nil input' do 
      round_for_display(nil).should == nil
    end
  end
end
