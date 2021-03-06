FactoryGirl.define do
  sequence :name do |n|
    "Foo bar #{n}"
  end

  sequence :email do |n|
    "person#{n}@example.com"
  end

  sequence :uid do |n|
    "#{n}"
  end

  sequence :permalink do |n|
    "foo_page_#{n}"
  end

  factory :project_faq do |f|
    f.title "Foo bar"
    f.answer "Bar foo"
    f.association :project
  end

  factory :project_document do |f|
    f.name 'name'
    f.document "foo.png"
    f.association :project
  end

  factory :user do
    confirmed_at { Time.now }
    email        { "sherlock.holmes#{rand}@example.com" }
    password     '123123123'

    trait :beta do
      beta true
      access_code
    end

    trait :with_brokerage_account do
      after(:create) do |instance|
        create :brokerage_account, user: instance
      end
    end

    trait :unconfirmed do
      confirmed_at nil
    end
  end

  factory :user_with_uploaded_image, parent: :user do |f|
    f.uploaded_image File.open("#{Rails.root}/spec/fixtures/image.png")
  end

  factory :category do
    name { "Category ##{rand}" }
  end

  factory :project do
    address_city       'Kansas City'
    address_state      'MO'
    credit_type        'general_obligation'
    goal               10000
    headline           'Foo bar'
    home_page          true
    how_know           'Lorem ipsum'
    minimum_investment 500
    name               'Foo bar'
    online_days        30
    permalink          { "#{name.parameterize}-#{SecureRandom.hex}" }
    statement_file_url 'http://example.com/statement.pdf'
    online_date        { -1.day.from_now }
    state              'online'
    summary            'Foo bar'
    video_url          'http://vimeo.com/17298435'
    category
    user

    trait :with_rewards do
      after(:create) do |instance|
        create :reward, project: instance
      end
    end
  end

  factory :unsubscribe do |f|
    f.association :user, factory: :user
    f.association :project, factory: :project
  end

  factory :notification do |f|
    f.association :user, factory: :user
    f.association :contribution, factory: :contribution
    f.association :project, factory: :project
    f.template_name 'payment_confirmed'
    f.origin_name 'Foo Bar'
    f.origin_email 'foo@bar.com'
    f.locale 'en'
  end

  factory :reward do
    happens_at { 3.years.from_now }
    project
  end

  factory :activity do |f|
    project
    user
    title 'Foo Bar'
    summary 'Foo Bar Summary'
    happened_at { Time.now }
  end

  factory :contribution do |f|
    f.association :project, factory: :project
    f.association :user, factory: :user
    f.confirmed_at Time.now
    f.value 10.00
    f.state 'confirmed'
  end

  factory :payment_notification do |f|
    f.association :contribution, factory: :contribution
    f.extra_data {}
  end

  factory :authorization do |f|
    f.association :oauth_provider
    f.association :user
    f.uid 'Foo'
  end

  factory :oauth_provider do |f|
    f.name 'facebook'
    f.strategy 'GitHub'
    f.path 'github'
    f.key 'test_key'
    f.secret 'test_secret'
  end

  factory :institutional_video do |f|
    f.title "My title"
    f.description "Some Description"
    f.video_url "http://vimeo.com/35492726"
    f.visible false
  end

  factory :update do |f|
    f.association :project, factory: :project
    f.association :user, factory: :user
    f.title "My title"
    f.comment "This is a comment"
    f.comment_html "<p>This is a comment</p>"
  end

  factory :state do
    name "RJ"
    acronym "RJ"
  end

  factory :press_asset do
    title 'Lorem'
    url 'http://lorem.com'
    image File.open("#{Rails.root}/spec/fixtures/image.png")
  end

  factory :tag do
    name 'bike'
  end

  factory :organization do |f|
    f.association :user
    f.name 'Organization name'
    f.image File.open("#{Rails.root}/spec/fixtures/image.png")
  end

  factory :users_oauth_provider, class: 'UsersOauthProviders' do
    oauth_provider 1
    user_id 1
    uid "MyText"
  end

  factory :contact do
    first_name 'First'
    last_name 'Last'
    email 'some@email.com'
    subject 'Test'
  end

  factory :image do |f|
    f.association :user
    f.file File.open("#{Rails.root}/spec/fixtures/image.png")
  end

  factory :brokerage_account do
    address '221B Baker Street'
    email   'sherlock.holmes@example.com'
    name    'Sherlock Holmes'
    phone   '+44 20 7224 3688'
    tax_id  '123-45-6789'
    user
  end

  factory :access_code do
    code 'asdf'
  end
end
