require 'spec_helper'

describe BhsiLongtext do

  let(:bl) { BhsiLongtext.new }

  describe 'Validations' do

    [:about_yourself, :social_venture_description, :strong_midwest_connections_explained,
     :venture_launched, :number_people_affected, :explain_number, :organizational_development,
     :three_standout_statistics].each do |attribute|
      it "requires #{attribute}" do
        assert_presence bl, attribute
      end
    end

    it 'requires valid about_yourself min words count' do
      bl.about_yourself = 'word '
      assert_min_words_count bl, :about_yourself, BhsiLongtext::MIN_ABOUT_YOURSELF_WORDS

      bl.about_yourself << 'word ' * BhsiLongtext::MIN_ABOUT_YOURSELF_WORDS
      bl.should be_invalid
      bl.errors[:about_yourself].should be_empty
    end

    it 'requires valid about_yourself max words count' do
      bl.about_yourself = 'word ' * BhsiLongtext::MAX_ABOUT_YOURSELF_WORDS
      bl.errors[:about_yourself].should be_empty

      bl.about_yourself << 'word'
      assert_max_words_count bl, :about_yourself, BhsiLongtext::MAX_ABOUT_YOURSELF_WORDS
    end

    it 'requires valid social_venture_description max words count' do
      bl.social_venture_description = 'word ' * BhsiLongtext::MAX_SOCIAL_VENTURE_DESC_WORDS
      bl.errors[:social_venture_description].should be_empty

      bl.social_venture_description << 'word'
      assert_max_words_count bl, :social_venture_description, BhsiLongtext::MAX_SOCIAL_VENTURE_DESC_WORDS
    end

    it 'requires valid strong_midwest_connections_explained min words count' do
      bl.strong_midwest_connections_explained = 'word '
      assert_min_words_count bl, :strong_midwest_connections_explained, BhsiLongtext::MIN_STRONG_MIDWEST_WORDS

      bl.strong_midwest_connections_explained << 'word ' * BhsiLongtext::MIN_STRONG_MIDWEST_WORDS
      bl.should be_invalid
      bl.errors[:strong_midwest_connections_explained].should be_empty
    end

    it 'requires valid strong_midwest_connections_explained max words count' do
      bl.strong_midwest_connections_explained = 'word ' * BhsiLongtext::MAX_STRONG_MIDWEST_WORDS
      bl.errors[:strong_midwest_connections_explained].should be_empty

      bl.strong_midwest_connections_explained << 'word'
      assert_max_words_count bl, :strong_midwest_connections_explained, BhsiLongtext::MAX_STRONG_MIDWEST_WORDS
    end

  end

end
