require 'spec_helper'

describe Material do

  let(:material) { Material.new }

  describe 'Validations' do

    [:name, :thumbnail, :document].each do |attribute|
      it "requires #{attribute}" do
        assert_presence material, attribute
      end
    end

  end

end
