FactoryGirl.define do
  factory :entry do
    user
    content 'Lorem ipsum'
    content_html { "<p>#{content}</p>\n" }
  end
end
