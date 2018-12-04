require 'rails_helper'
require 'byebug'

RSpec.describe KepplerFrontend::Callbacks::CodeHandler, type: :services do

  context 'Callback handler' do
    before(:each) do
      @callback = create(:keppler_frontend_callback_functions)
      @code =  KepplerFrontend::Callbacks::CodeHandler.new(@callback)

      @front = KepplerFrontend::Urls::Front.new
      @controller = File.readlines(@front.controller)
      @search = KepplerFrontend::Utils::CodeSearch.new(@controller)
    end

    let(:code_install) { @code.install }

    let(:function_exist) do
      idx_one, idx_two = @search.search_section("    # begin callback #{@callback.name}\n", 
                                               "    # end callback #{@callback.name}\n")
      @controller[idx_one..idx_two].count == 1 ? false : true
    end

    let(:code_uninstall) { @code.uninstall }

    context 'install' do
      it { expect(code_install).to eq(true) }
      it { expect(function_exist).to eq(true) }
    end

    context 'uninstall' do
      it { expect(code_uninstall).to eq(true) }
      it { expect(function_exist).to eq(false) }
    end
  end
end