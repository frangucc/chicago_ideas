require 'spec_helper'

describe BhsiApplication do

  let(:bhsi) { BhsiApplication.new }

  describe 'Validations' do

    [:first_name, :last_name, :address1, :city, :state, :phone_number, :zipcode, :email, :gender,
     :birthdate, :title, :social_venture_name, :legal_structure, :url, :twitter_handle, :video_url,
     :applied_before, :reference_1_name, :reference_1_relationship, :reference_1_email,
     :reference_2_name, :reference_2_relationship, :reference_2_phone, :reference_2_email,
     :makes_social_innovation, :inspiration, :improvements, :distinguish_yourself,
     :total_budget_current_year, :major_sources_income, :impact, :obstacles_needs,
     :previous_budget, :current_budget, :venture_standard_deck, :org_join_point].each do |attribute|
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

    it 'requires valid major_sources_income words count' do
      bhsi.major_sources_income = 'word ' * BhsiApplication::MAX_MAJOR_SOURCES_INCOME_WORDS
      bhsi.errors[:major_sources_income].should be_empty

      bhsi.major_sources_income << 'word'
      assert_max_words_count bhsi, :major_sources_income, BhsiApplication::MAX_MAJOR_SOURCES_INCOME_WORDS
    end

    it 'requires valid impact words count' do
      bhsi.impact = 'word ' * BhsiApplication::MAX_IMPACT_WORDS
      bhsi.errors[:impact].should be_empty

      bhsi.impact << 'word'
      assert_max_words_count bhsi, :impact, BhsiApplication::MAX_IMPACT_WORDS
    end

    it 'requires valid obstacles_needs words count' do
      bhsi.obstacles_needs = 'word ' * BhsiApplication::MAX_OBSTACLES_NEEDS_WORDS
      bhsi.errors[:obstacles_needs].should be_empty

      bhsi.obstacles_needs << 'word'
      assert_max_words_count bhsi, :obstacles_needs, BhsiApplication::MAX_OBSTACLES_NEEDS_WORDS
    end

    it 'requires valid email' do
      ['invalid_email', 'invalid_email@', 'invalid@email', 'invalid@email.'].each do |invalid_email|
        bhsi.email = invalid_email
        assert_email bhsi, :email
      end
    end

    it 'requires valid reference_1_email' do
      ['invalid_email', 'invalid_email@', 'invalid@email', 'invalid@email.'].each do |invalid_email|
        bhsi.reference_1_email = invalid_email
        assert_email bhsi, :reference_1_email
      end
    end

    it 'requires valid reference_1_email' do
      ['invalid_email', 'invalid_email@', 'invalid@email', 'invalid@email.'].each do |invalid_email|
        bhsi.reference_2_email = invalid_email
        assert_email bhsi, :reference_2_email
      end
    end

    it 'requires valid phone_number' do
      ['123', '123-', '123-456', '123-456-', '123-456-789', '1234-567-8901'].each do |invalid_phone|
        bhsi.phone_number = invalid_phone
        assert_phone_number bhsi, :phone_number
      end
      bhsi.phone_number = '123-456-7890'
      bhsi.should be_invalid
      bhsi.errors[:phone_number].should be_empty
    end

    it 'requires valid reference_1_phone' do
      ['123', '123-', '123-456', '123-456-', '123-456-789', '1234-567-8901'].each do |invalid_phone|
        bhsi.reference_1_phone = invalid_phone
        assert_phone_number bhsi, :reference_1_phone
      end
      bhsi.reference_1_phone = '123-456-7890'
      bhsi.should be_invalid
      bhsi.errors[:reference_1_phone].should be_empty
    end

    it 'requires valid reference_2_phone' do
      ['123', '123-', '123-456', '123-456-', '123-456-789', '1234-567-8901'].each do |invalid_phone|
        bhsi.reference_2_phone = invalid_phone
        assert_phone_number bhsi, :reference_2_phone
      end
      bhsi.reference_2_phone = '123-456-7890'
      bhsi.should be_invalid
      bhsi.errors[:reference_2_phone].should be_empty
    end

  end

  describe "#generate_application_pdf" do
    it "creates the pdf file" do
      @ba = FactoryGirl.build(:bhsi_application)
      @ba.stub(:notify_staff)
      @ba.stub(:notify_applicant)
      @ba.previous_budget = File.open("./spec/fixtures/blank.pdf")
      @ba.should_receive(:generate_application_pdf)
      @ba.save

      @ba.pdf.should_not be_nil
    end
  end

end
