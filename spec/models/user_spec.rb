require 'rails_helper'

RSpec.describe User, type: :model do

  it "vai dar certo" do
    expect(1).to eql(1)
  end

  it "vai dar erro" do
    expect(1).to eql(2)
  end
end
