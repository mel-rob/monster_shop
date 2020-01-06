class MerchantsController < ApplicationController

  def index
    @merchants = Merchant.all
  end

  def show
    if current_admin?
      redirect_to "/admin/merchants/#{params[:id]}"
    end
    @merchant = Merchant.find(params[:id])
  end

  def new
  end

  def create
    merchant = Merchant.create(merchant_params)
    if merchant.save
      redirect_to merchants_path
    else
      flash[:error] = merchant.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:id])
    @merchant.update(merchant_params)
    if @merchant.save
      redirect_to "/merchants/#{@merchant.id}"
    else
      flash[:error] = @merchant.errors.full_messages.to_sentence
      render :edit
    end
  end

  def update_disabled
    @merchant = Merchant.find(params[:id])
    @merchant.toggle(:disabled).save
    @merchant.items.update_all(disabled: true)
    flash[:notice] = 'This merchant has walked the plank.'
    redirect_to "/merchants"
  end

  def destroy
    Merchant.destroy(params[:id])
    redirect_to '/merchants'
  end

  private

  def merchant_params
    params.permit(:name,:address,:city,:state,:zip,:disabled)
  end

end
