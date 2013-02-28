require 'spec_helper'

describe CooperativeApplication do

  let(:co_app) { CooperativeApplication.new }

  describe 'Validations' do

    ['name', 'last_name', 'organization', 'phone', 'email', 'org_mission', 'org_website', 'org_twitter', 'reason', 'worked_on', 'part_meaningful', 'ins_failure', 'neighborhood', 'assisted_area', 'recommend'].each do |attr|
      it "requires #{attr}" do
        assert_presence co_app, attr.to_sym
      end
    end

    it 'requires valid email' do
      ['invalid_email', 'invalid_email@', 'invalid@email', 'invalid@email.'].each do |invalid_email|
        co_app.email = invalid_email
        assert_email co_app, :email
      end
    end

    it 'requires valid worked_on words count' do
      co_app.worked_on = 'word ' * CooperativeApplication::MAX_WORKED_ON_WORDS
      co_app.errors[:worked_on].should be_empty

      co_app.worked_on << 'word'
      assert_max_words_count co_app, :worked_on, CooperativeApplication::MAX_WORKED_ON_WORDS
    end

    it 'requires valid part_meaningful words count' do
      co_app.part_meaningful = 'word ' * CooperativeApplication::MAX_PART_MEANINGFUL_WORDS
      co_app.errors[:part_meaningful].should be_empty

      co_app.part_meaningful << 'word'
      assert_max_words_count co_app, :part_meaningful, CooperativeApplication::MAX_PART_MEANINGFUL_WORDS
    end

    it 'requires valid ins_failure words count' do
      co_app.ins_failure = 'word ' * CooperativeApplication::MAX_INS_FAILURE_WORDS
      co_app.errors[:ins_failure].should be_empty

      co_app.ins_failure << 'word'
      assert_max_words_count co_app, :ins_failure, CooperativeApplication::MAX_INS_FAILURE_WORDS
    end

    it 'requires valid neighborhood words count' do
      co_app.neighborhood = 'word ' * CooperativeApplication::MAX_NEIGHBORHOOD_WORDS
      co_app.errors[:neighborhood].should be_empty

      co_app.neighborhood << 'word'
      assert_max_words_count co_app, :neighborhood, CooperativeApplication::MAX_NEIGHBORHOOD_WORDS
    end

  end

end
