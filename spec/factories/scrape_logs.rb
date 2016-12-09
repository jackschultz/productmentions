FactoryGirl.define do
  factory :scrape_log do
    type ""
    start_time "2016-12-09 13:44:14"
    end_time "2016-12-09 13:44:14"
    start_ident "MyString"
    end_ident "MyString"
    mention_count 1
    comment_count 1
    error false
    error_message "MyString"
  end
end
