require 'rails_helper'

RSpec.describe Event, type: :model do
  before do
    @event = FactoryBot.create(:event)
  end

  describe "Event.new" do
    it "Eventモデルをnewしたとき、nilではないこと" do
      expect(Event.new).not_to eq(nil)
    end
  end

  describe "Event#created_by?" do
    it "Event#created_by? owner_idと引数の#idが同じ時" do
      expect(@event.created_by?(@event.owner)).to eq(true)
    end
    it "#created_by? owner_idと引数の#idが異なる時" do
      another_user = FactoryBot.create(:user)
      expect(@event.created_by?(another_user)).to eq(false)
    end
    it "#created_by? 引数がnilな時" do
      expect(@event.created_by?(nil)).to eq(false)
    end
  end

  describe "Event#start_at_should_be_before_end_at" do
    it "start_at_should_be_before_end_at validation OK" do
      start_at = rand(1..30).days.from_now
      end_at = start_at + rand(1..30).hours
      event = FactoryBot.build(:event, start_at:, end_at:)
      event.valid?
      expect(event.errors[:start_at]).not_to include("は終了時間よりも前に設定してください")
    end
    it "start_at_should_be_before_end_at validation error" do
      start_at = rand(1..30).days.from_now
      end_at = start_at - rand(1..30).hours
      event = FactoryBot.build(:event, start_at:, end_at:)
      event.valid?
      expect(event.errors[:start_at]).to include("は終了時間よりも前に設定してください")
    end
  end
end
