require 'rails_helper'

RSpec.describe Message, type: :model do
  describe '#create' do
    before do
      @message = FactoryBot.build(:message)
    end
    it 'contentとimageが存在していれば保存できること' do
      expect(@message).to be_valid
    end
    it 'contentが空でも保存できること' do
      @message.content = ''
      expect(@message).to be_valid
    end
    it 'imageが空でも保存できること' do
      @message.image = nil
      expect(@message).to be_valid
    end
    it 'contentとimageが空では保存できないこと' do
      @message.content = ''
      @message.image = nil
      @message.valid?
      expect(@message.errors.full_messages).to include("Content can't be blank")
    end
    it 'roomが紐づいていないと保存できないこと' do
      @message.room = nil
      @message.valid?
      expect(@message.errors.full_messages).to include("Room must exist")
    end
    it 'userが紐づいていないと保存できないこと' do
      @message.user = nil
      @message.valid?
      expect(@message.errors.full_messages).to include("User must exist")
    end
  end
end

# MySQLのエラーが出た場合のみ、以下を実施しましょう
# active_storageを用いたモデルの単体テストをする際に、環境によってはMySQLのエラーが発生する場合があります。
# もしMySQL client is not connectedというエラーが発生した場合は、config/environments/test.rbというファイルに以下の記述を追記しましょう。

# config/environments/test.rb
# Rails.application.configure do

#  #省略

#  config.active_job.queue_adapter = :inline #追記

#  #省略