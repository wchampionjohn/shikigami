require "shikigami/view_helpers"
require "i18n"
require "action_view"
require_relative "fixtures/rails_test_helper"

describe Shikigami::ViewHelpers do
  before(:each) do
    I18n.config.available_locales = :"zh-TW"
    I18n.locale= :"zh-TW"
    I18n.load_path << "spec/fixtures/zh-TW.yml"
    @helper = Shikigami::RailsTestHelper.new
  end

  describe "#no_data_alert" do
    context "when the message is specified" do
      it "should honor the specified message" do
        expect(@helper.no_data_alert("TEST")).to eq "<div class=\"alert alert-warning\">TEST</div>"
      end
    end

    context "when the message is not specified" do
      it "should fall back to the default message" do
        expect(@helper.no_data_alert).to eq "<div class=\"alert alert-warning\">尚無資料</div>"
      end
    end
  end

  describe "#bootsrap_dropdown_title" do
    it "should generate the correct html" do
      expect(@helper.bs_dd_title("something")).to eq "<a class=\"dropdown-toggle\" data-toggle=\"dropdown\" role=\"button\" aria-haspopup=\"true\" aria-expanded=\"false\">something<span class=\"caret\"></span></a>"
    end
  end

  describe "#bootstrap_button" do
    context "when no options are specified" do
      context "when used for #show" do
        it "should default to btn-xs and btn-info" do
          expect(@helper.bs_btn(:show, "#")).to eq "<a class=\"btn btn-xs btn-info\" href=\"#\">檢視</a>"
        end
      end

      context "when used for #edit" do
        it "should default to btn-xs and btn-warning" do
          expect(@helper.bs_btn(:edit, "#")).to eq "<a class=\"btn btn-xs btn-warning\" href=\"#\">修改</a>"
        end
      end

      context "when used for #destroy" do
        it "should default to btn-xs and btn-danger" do
          expect(@helper.bs_btn(:destroy, "#")).to eq "<a class=\"btn btn-xs btn-danger\" href=\"#\">刪除</a>"
        end
      end

      context "when used for actions other than #show, #edit, #destroy" do
        it "should default to btn-xs and btn-primary" do
          expect(@helper.bs_btn(:new, "#")).to eq "<a class=\"btn btn-xs btn-primary\" href=\"#\">新增</a>"
        end
      end
    end

    context "when the style option is specified" do
      it "should honor the specified style" do
        expect(@helper.bs_btn(:edit, "#", style: "danger")).to eq "<a class=\"btn btn-xs btn-danger\" href=\"#\">修改</a>"
      end
    end

    context "when the size option is specified" do
      it "should honor the specified size" do
        expect(@helper.bs_btn(:edit, "#", size: "m")).to eq "<a class=\"btn btn-m btn-warning\" href=\"#\">修改</a>"
      end
    end

    context "when the method option is specified" do
      it "should generate html with the specified method" do
        expect(@helper.bs_btn(:destroy, "#", method: :delete)).to eq "<a class=\"btn btn-xs btn-danger\" rel=\"nofollow\" data-method=\"delete\" href=\"#\">刪除</a>"
      end
    end

    context "when the confirm option is specified" do
      it "should generate html with the specified confirm message" do
        expect(@helper.bs_btn(:destroy, "#", confirm: true)).to eq "<a class=\"btn btn-xs btn-danger\" data-confirm=\"確認要刪除？\" href=\"#\">刪除</a>"
      end
    end
  end
end