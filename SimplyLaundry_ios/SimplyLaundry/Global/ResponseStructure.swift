//
//  ResponseStructure.swift
//  SimplyLaundry
//
//  Created by webclues on 22/01/19.
//  Copyright © 2019 webclues. All rights reserved.
//

import Foundation

let isSelected_Key = "isSelected"

//MARK:- Request Parameter Structure
struct ResponceKey_Login_User{
    static let auth_token = "auth_token"
    static let display_name = "display_name"
    static let email = "email"
    static let registered_via = "registered_via"
    static let user_id = "user_id"
    static let user_type = "user_type"
    struct user_type_value{
        static let Individual = "Individual"
        static let Company = "Company"
    }
    static let phone = "phone"
}

struct ResponceKey_get_all_country{
    static let country_id = "country_id"
    static let status = "status"
    static let country_name = "country_name"
    static let country_iso = "country_iso"
    static let created_on = "created_on"
    static let modified_on = "modified_on"
}
struct ResponceKey_get_all_state{
    static let state_name = "state_name"
    static let state_id = "state_id"
}

struct CleanClothesParameters
{
    static let pickup_address_id = "pickup_address_id"
    static let dropoff_address_id = "dropoff_address_id"
    static let handoff_pick_id = "handoff_pick_id"
    static let handoff_delivery_id = "handoff_delivery_id"
    static let service_id = "service_id"
    static let sepc_instraction = "sepc_instraction"
    static let delivery_option = "delivery_option"
    static let detergent_id = "detergent_id"
    static let bleach_id = "bleach_id"
    static let fabric_id = "fabric_id"
    static let extra_services = "extra_services"
}
struct get_all_servicesResponce
{
    static let isSelected = "isSelected"
    static let delivery_option = "delivery_option"
    static let wash_service = "wash_service"
    struct wash_service_value {
        static let service_id = "service_id"
        static let service_slug = "service_slug"
        static let service_name = "service_name"
        static let service_img = "service_img"
        static let active_service_img = "active_service_img"
        static let min_order = "min_order"
    }
    struct delivery_option_values {
        static let delivery_option_id = "delivery_option_id"
        static let delivery_name = "delivery_name"
        static let option_type = "option_type"
        static let delivery_value = "delivery_value"
        static let delivery_hour = "delivery_hour"
    }
    static let detergent = "detergent"
    static let bleach = "bleach"
    static let fabric_softner = "fabric_softner"
    static let bed_bugs_treatment = "bed_bugs_treatment"
    static let special_instructions = "special_instructions"
    struct values {
        static let additional_service_id = "additional_service_id"
        static let status = "status"
        static let additional_service_category_id = "additional_service_category_id"
        static let name = "name"
        static let price = "price"
        static let created_on = "created_on"
        static let modified_on = "modified_on"
        static let is_selected = "is_selected"
    }
    
    static let orderDetails = "order_details"
    static let promocode = "promocode"
    static let promocode_str = "promocode_str"
}
struct get_delivery_optionResponce
{
    static let isSelected = "isSelected"
    struct dataValues {
        static let delivery_option_id = "delivery_option_id"
        static let delivery_name = "delivery_name"
        static let option_type = "option_type"
        static let delivery_value = "delivery_value"
        static let delivery_hour = "delivery_hour"
    }
}
struct ResponceKey_get_time_slot{
    static let data = "data"
    struct dataValues {
        static let time_slot_id = "time_slot_id"
        static let time_title = "time_title"
        static let time_from = "time_from"
        static let time_to = "time_to"
        static let team_id = "team_id"
        static let slug = "slug"
    }
}

struct ResponceKey_get_all_credit_card{
    static let data = "data"
    struct dataValues {
        static let payment_profile_id = "payment_profile_id"
        static let payment_card_no = "payment_card_no"
        static let payment_cart_type = "payment_cart_type"
        static let is_default = "is_default"
    }
}

struct ResponceKey_get_all_price_details {
    static let service_categories = "service_categories"
    static let product_pricing = "product_pricing"
    static let products = "product_list"
    struct service_product{
        static let service_category_id = "service_category_id"
        static let service_categry_name = "service_categry_name"
        static let service_categry_img = "service_categry_img"
        static let service_categry_desc = "service_categry_desc"
        static let service_categry_short_desc = "service_categry_short_desc"
        static let is_both = "is_both"
        static let service_id = "service_id"
        static let product_id = "product_id"
        static let product_name = "product_name"
        static let product_price = "product_price"
        static let is_weight = "is_weight"
        static let product_category_id = "product_category_id"
        static let product_category_name = "product_category"
    }
}

struct ResponceKey_success_order
{
    static let order_id = "order_id"
    static let display_order_id = "display_order_id"
    static let status = "status"
    static let customer_id = "customer_id"
    static let pickup_address_id = "pickup_address_id"
    static let pickup_address = "pickup_address"
    static let delivery_address_id = "delivery_address_id"
    static let delivery_address = "delivery_address"
    static let address_type = "address_type"
    static let service_type = "service_type"
    static let order_status_id = "order_status_id"
    static let pickup_date = "pickup_date"
    static let pickup_time_slot_id = "pickup_time_slot_id"
    static let delivery_date = "delivery_date"
    static let delivery_time_slot_id = "delivery_time_slot_id"
    static let delivery_option_id = "delivery_option_id"
    static let promocode_id = "promocode_id"
    static let special_instructions = "special_instructions"
    static let delivery_option_percentage = "delivery_option_percentage"
    static let general_delivery_option_amount = "general_delivery_option_amount"
    static let credit_delivery_option_amount = "credit_delivery_option_amount"
    static let tip_percentage = "tip_percentage"
    static let general_tip_amount = "general_tip_amount"
    static let credit_tip_amount = "credit_tip_amount"
    static let promocode_percentage = "promocode_percentage"
    static let general_promocode_amount = "general_promocode_amount"
    static let credit_promocode_amount = "credit_promocode_amount"
    static let tax_percentage = "tax_percentage"
    static let general_tax_amount = "general_tax_amount"
    static let credit_tax_amount = "credit_tax_amount"
    static let general_service_amount = "general_service_amount"
    static let credit_service_amount = "credit_service_amount"
    static let general_additional_service_amount = "general_additional_service_amount"
    static let credit_additional_service_amount = "credit_additional_service_amount"
    static let general_subtotal = "general_subtotal"
    static let credit_subtotal = "credit_subtotal"
    static let general_total = "general_total"
    static let credit_total = "credit_total"
    static let order_total = "order_total"
    static let credit_card_verification = "credit_card_verification"
    static let user_package_id = "user_package_id"
    static let package_credits = "package_credits"
    static let user_credits = "user_credits"
    static let extra_charge = "extra_charge"
    static let final_order_total = "final_order_total"
    static let is_donation = "is_donation"
    static let comment = "comment"
    static let deleted = "deleted"
    static let created_on = "created_on"
    static let modified_on = "modified_on"
    static let pickup_job_id = "pickup_job_id"
    static let delivery_job_id = "delivery_job_id"
    static let valid_transaction_id = "valid_transaction_id"
    static let payment_profile_id = "payment_profile_id"
    static let payment_method = "payment_method"
    static let is_repeat = "is_repeat"
    static let repeat_order_id = "repeat_order_id"
    static let delivery_name = "delivery_name"
    static let pickup_time = "pickup_time"
    static let delivery_time = "delivery_time"
    static let display_name = "display_name"
    static let service = "service"
}

struct ResponceKey_get_global {
    static var holiday_dates = [String]()
    static var fullDayHours = 24
    static var halfDayHours = 12
    static var cut_off_time = String()
    static var beforDayOf_FullDayOffName = String()
    static var fullDayOffName = String()
    static var halfdayOffName = String()
    init(dic:NSDictionary) {
        
        ResponceKey_get_global.holiday_dates = { () -> [String] in
            let split = (dic.value(forKey: "holiday_dates") as! String).split(separator: ",")
            var array = [String]()
            for i in 0..<split.count
            {
                array.append("\(split[i])")
            }
            
            return array
        }()
        var day = Int(Int("\(dic.value(forKey: "full_day_off")!)")! - 1)
        if day == -1
        {
            day = 1
        }
        ResponceKey_get_global.beforDayOf_FullDayOffName = getday(strDate: "\(day)")
        ResponceKey_get_global.fullDayOffName = getday(strDate: dic.value(forKey: "full_day_off") as! String)
        ResponceKey_get_global.halfdayOffName = getday(strDate: dic.value(forKey: "half_day_off") as! String)
        ResponceKey_get_global.cut_off_time = dic.value(forKey: "cut_off_time") as! String
    }
}

func getday(strDate:String)->String
{
    switch (strDate) {
    case "0": return "sun"
    case "1":return "mon"
    case "2":return "tue"
    case "3":return "wed"
    case "4":return "thu"
    case "5":return"fri"
    case "6":return "sat"
    default: return " "
    }
}

struct ResponceKey_get_packages{
    static let id = "id"
    static let package_name = "package_name"
    static let package_description = "package_description"
    static let package_amount = "package_amount"
    static let package_price = "package_price"
    static let is_active_package = "is_active_package"
    struct package_price_value{
        static let price = "price"
        static let service_name = "service_name"
    }
}

struct ResponceKey_pack_detail{
    static let active_package = "active_package"
    static let history_package = "history_package"
    static let package_id = "package_id"
    static let user_package_id = "user_package_id"
    static let package_name = "package_name"
    static let package_description = "package_description"
    static let package_amount = "package_amount"
    static let created_on = "created_on"
    static let expired_on = "expired_on"
    static let status = "status"
    static let package_price = "package_price"
    static let credits = "credits"
    struct package_price_value{
        static let price = "price"
        static let service_name = "service_name"
    }
}

struct ResponceKey_order_data
{
    static let order_data = "order_data"
    static let order_id = "order_id"
    static let display_order_id = "display_order_id"
    static let status = "status"
    static let cancel_order_status = "cancel_order_status"
    static let customer_id = "customer_id"
    static let pickup_address_id = "pickup_address_id"
    static let pick_up_address = "pickup_address"
    static let delivery_address_id = "delivery_address_id"
    static let delivery_address = "delivery_address"
    static let address_type = "address_type"
    static let service_type = "service_type"
    static let order_status_id = "order_status_id"
    static let pickup_date = "pickup_date"
    static let pickup_time_slot_id = "pickup_time_slot_id"
    static let delivery_date = "delivery_date"
    static let delivery_time_slot_id = "delivery_time_slot_id"
    static let delivery_option_id = "delivery_option_id"
    static let promocode_id = "promocode_id"
    static let special_instructions = "special_instructions"
    static let delivery_option_percentage = "delivery_option_percentage"
    static let general_delivery_option_amount = "general_delivery_option_amount"
    static let credit_delivery_option_amount = "credit_delivery_option_amount"
    static let tip_percentage = "tip_percentage"
    static let general_tip_amount = "general_tip_amount"
    static let credit_tip_amount = "credit_tip_amount"
    static let promocode_percentage = "promocode_percentage"
    static let general_promocode_amount = "general_promocode_amount"
    static let credit_promocode_amount = "credit_promocode_amount"
    static let tax_percentage = "tax_percentage"
    static let general_tax_amount = "general_tax_amount"
    static let credit_tax_amount = "credit_tax_amount"
    static let general_service_amount = "general_service_amount"
    static let credit_service_amount = "credit_service_amount"
    static let general_additional_service_amount = "general_additional_service_amount"
    static let credit_additional_service_amount = "credit_additional_service_amount"
    static let general_min_order_charge = "general_min_order_charge"
    static let credit_min_order_charge = "credit_min_order_charge"
    static let general_subtotal = "general_subtotal"
    static let credit_subtotal = "credit_subtotal"
    static let general_total = "general_total"
    static let credit_total = "credit_total"
    static let order_total = "order_total"
    static let credit_card_verification = "credit_card_verification"
    static let user_package_id = "user_package_id"
    static let package_credits = "package_credits"
    static let user_credits = "user_credits"
    static let extra_charge = "extra_charge"
    static let final_order_total = "final_order_total"
    static let is_donation = "is_donation"
    static let comment = "comment"
    static let deleted = "deleted"
    static let created_on = "created_on"
    static let created_by = "created_by"
    static let modified_on = "modified_on"
    static let pickup_job_id = "pickup_job_id"
    static let delivery_job_id = "delivery_job_id"
    static let valid_transaction_id = "valid_transaction_id"
    static let payment_profile_id = "payment_profile_id"
    static let payment_method = "payment_method"
    static let is_repeat = "is_repeat"
    static let is_repeat_order_type = "is_repeat_order_type"
    static let repeat_order_id = "repeat_order_id"
    static let pickup_time = "pickup_time"
    static let delivery_time = "delivery_time"
    static let display_name = "display_name"
    static let service = "service"
    static let order_status = "order_status"
    struct order_status_values{
        static let order_history_id = "order_history_id"
        static let order_id = "order_id"
        static let order_status = "order_status"
        static let order_status_id = "order_status_id"
        static let comment = "comment"
        static let created_on = "created_on"
    }
    static let slug = "slug"
    struct slug_values{
        static let order_received = "order_received"
        static let picked_up = "picked_up"
        static let pickedup_successful = "pickedup_successful"
        static let processing = "processing"
        static let being_cleaned = "being_cleaned"
        static let processed = "processed"
        static let delivered = "delivered"
        static let delivered_successful = "delivered_successful"
        static let voided = "voided"
        static let cancelled = "cancelled"
        static let refunded = "refunded"
        static let complete = "complete"
    }
}

struct ResponceKey_user_credit{
    static let credit_detail = "credit_detail"
    struct credit_detail_values{
        static let credits = "credits"
        static let date = "date"
        static let transaction_type = "transaction_type"
        static let gift_card_cancel_admin = "gift_card_cancel_admin"
        static let type = "type"
        static let detail = "detail"
    }
    struct values{
        static let credited = "credited"
    }
    static let total_amount = "total_amount"
}

struct ResponceKey_get_how_hear_about_ust{
    static let how_hear_about_us_id = "how_hear_about_us_id"
    static let label = "label"
}

struct ResponceKey_get_gift_card{
    static let sent = "sent"
    static let received = "received"
    struct values{
        static let id = "id"
        static let amount = "amount"
        static let is_registered = "is_registered"
        static let gift_code = "gift_code"
        static let created_on = "created_on"
        static let add_note = "add_note"
        static let referee_email = "referee_email"
        static let referee_name = "referee_name"
        static let referral_name = "referral_name"
    }
    struct giftCardStatus{
        static let notRedeem = "0"
        static let redeem = "1"
        static let cancelByAdmin = "2"
        static let cancelByUser = "3"
    }
}

struct ResponceKey_get_how_hear_about_us {
    static var arrHowAboutUs : NSArray = NSArray()
    init(dic:NSArray) {
        ResponceKey_get_how_hear_about_us.arrHowAboutUs = dic
    }
}
struct ResponceKey_pricelist{
    static var arrServices = NSMutableArray()
    static var arrDryClean = NSMutableArray()
    static var arrLuandry = NSMutableArray()
}

struct ResponceKey_ReferrDetails{
    static var dicFereDetails = NSDictionary()
}
//MARK:- Request Parameters
struct RequestParameters_place_order
{
    static let user_id = "user_id"
    static let pick_up_address = "pick_up_address"
    static let delivery_address = "delivery_address"
    
    static let service_address_1 = "service_address_1"
    struct service_address1_values{
        static let Apartment = "Apartment"
        static let House = "House"
        static let Business = "Business"
    }
    static let service_address_2 = "service_address_2"
    struct service_address2_values{
        static let Concierge = "Concierge"
        static let Doorstep = "Doorstep"
        static let Present = "Present"
    }
    static let comment1 = "comment1"
    static let pickup_date = "pickup_date"
    static let pickup_time_slot_id = "pickup_time_slot_id"
    static let delivery_date = "delivery_date"
    static let delivery_time_slot_id = "delivery_time_slot_id"
    static let driver_tip = "driver_tip"
    static let donation = "donation"
    struct donation_values{
        static let yes = "1"
        static let no = "0"
    }
    static let delivery_option = "delivery_option"
    static let wash_service = "wash_service"
    static let promocode_id = "promocode_id"
    static let select_payment_account = "select_payment_account"
    struct select_payment_account_values{
        static let use_cim_payment_account = "use_cim_payment_account"
        static let create_new_credit_card = "create_new_credit_card"
    }
    static let payment_method = "payment_method"
    
    struct payment_method_values{
        static let Cheque = "Cheque"
        static let Credit_Card = "Credit Card (Authorize.Net-CIM)"
        static let Paypal = "Paypal"
    }
    
    static let order_platform = "order_platform"
    struct order_platform_values{
        static let Web = "Web"
        static let Web_Admin = "Web Admin"
        static let Android = "Android"
        static let Ios = "iOS"
    }
    
    static let billing_agreement_id = "billing_agreement_id"
    static let payment_profile_id = "payment_profile_id"
    static let cc_payment_customer_type = "cc_payment_customer_type"
    struct cc_payment_customer_type_values{
        static let individual = "individual"
        static let business = "business"
    }
    static let cc_number = "cc_number"
    static let card_expiry = "card_expiry"
    static let cc_cvv = "cc_cvv"
    static let agree = "agree"
    static let detergent = "detergent"
    static let bleach = "bleach"
    static let fabric = "fabric"
    static let bed_bugs = "bed_bugs"
    static let is_repeat = "is_repeat"
    struct is_repeat_values{
        static let yes = "1"
        static let no = "0"
    }
    static let is_repeat_order_type = "is_repeat_order_type"
}

struct RequestParameters_add_credit_card
{
    static let card_number = "card_number"
    static let card_expiry = "card_expiry"
    static let card_customer_type = "card_customer_type"
    struct card_customer_type_values{
        static let individual = "individual"
        static let business = "business"
    }
}

struct RequestParameters_pages
{
    static let privacypolicy = "privacypolicy"
    static let faq = "faq"
    static let termsandconditions =  "termsandconditions"
}

// Notification Key
struct NotificationHandel{
    static let logout = "logout"
    static let order_received = "order_received"
    static let order_complete = "order_complete"
    static let order_cancel = "order_cancel"
    static let referrer_credit = "referrer_credit"
    static let referred_credit = "referred_credit"
    static let package_buy = "package_buy"
    static let type_inactive_delete = "type_inactive_delete"
}
