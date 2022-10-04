module Integrations
  module V1
    class VouchersController < IntegrationsController
      def show
        voucher = current_integration.vouchers.find_by(external_id: params[:id])

        render json: VoucherBlueprint.render(voucher), status: :ok
      end
    end
  end
end
