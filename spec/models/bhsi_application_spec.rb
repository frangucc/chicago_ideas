require 'spec_helper'

describe BhsiApplication do

  let(:bhsi) { BhsiApplication.new }

  describe 'Validations' do

    [:first_name, :last_name, :address1, :city, :state, :phone_number, :zipcode, :email, :gender,
     :birthdate, :title, :social_venture_name, :legal_structure, :url, :twitter_handle, :video_url,
     :applied_before, :reference_1_name, :reference_1_relationship, :reference_1_email,
     :reference_2_name, :reference_2_relationship, :reference_2_phone, :reference_2_email,
     :user_id, :makes_social_innovation, :inspiration, :improvements].each do |attribute|
       it "requires #{attribute}" do
        assert_presence bhsi, attribute
       end
    end

    it 'requires valid makes_social_innovation words count' do
      bhsi.makes_social_innovation = 'word ' * BhsiApplication::MAX_MAKES_SOCIAL_INNOVATION_WORDS
      bhsi.errors[:makes_social_innovation].should be_empty

      bhsi.makes_social_innovation << 'word'
      assert_max_words_count bhsi, :makes_social_innovation, BhsiApplication::MAX_MAKES_SOCIAL_INNOVATION_WORDS
    end

    it 'requires valid inspiration words count' do
      bhsi.inspiration = 'word ' * BhsiApplication::MAX_INSPIRATION_WORDS
      bhsi.errors[:inspiration].should be_empty

      bhsi.inspiration << 'word'
      assert_max_words_count bhsi, :inspiration, BhsiApplication::MAX_INSPIRATION_WORDS
    end

    it 'requires valid sustainability_model words count' do
      bhsi.sustainability_model = 'word ' * BhsiApplication::MAX_SUSTAINABITILITY_MODEL_WORDS
      bhsi.errors[:sustainability_model].should be_empty

      bhsi.sustainability_model << 'word'
      assert_max_words_count bhsi, :sustainability_model, BhsiApplication::MAX_SUSTAINABITILITY_MODEL_WORDS
    end

    it 'requires valid improvements words count' do
      bhsi.improvements = 'word ' * BhsiApplication::MAX_IMPROVEMENTS_WORDS
      bhsi.errors[:improvements].should be_empty

      bhsi.improvements << 'word'
      assert_max_words_count bhsi, :improvements, BhsiApplication::MAX_IMPROVEMENTS_WORDS
    end

    it 'requires valid distinguish_yourself words count' do
      bhsi.distinguish_yourself = 'word ' * BhsiApplication::MAX_DISTINGUISH_YOURSELF_WORDS
      bhsi.errors[:distinguish_yourself].should be_empty

      bhsi.distinguish_yourself << 'word'
      assert_max_words_count bhsi, :distinguish_yourself, BhsiApplication::MAX_DISTINGUISH_YOURSELF_WORDS
    end

  end

end
