namespace :dev do
  # 請先執行 rails dev:fake_user，可以產生 20 個資料完整的 User 紀錄
  # 其他測試用的假資料請依需要自行撰寫

  task all: [:fake_user, :fake_post, :fake_reply]

  task fake_user: :environment do
    User.destroy_all
    20.times do |i|
      name = FFaker::Name::first_name

      user = User.new(
        name: name,
        email: "#{name}@example.co",
        password: "12345678",
      )

      user.save!
    end
    puts "now you have #{User.count} users data"
  end

  task fake_post: :environment do
    Post.destroy_all
    @users = User.all
    @users.each do |user|
      3.times do |i|
        Post.create!(title: FFaker::Lorem::sentence(10), description: FFaker::Lorem.paragraph,
          user_id: user.id,
        )
      end
    end
    puts "now you have #{Post.count} comments data"
  end

  task fake_reply: :environment do
    Reply.destroy_all
    Post.all.each do |post|
      rand(10).times do
        post.replies.create!(
          comment: FFaker::Lorem.paragraph,
          user_id: User.all.sample.id
        )
      end
    end
    puts "now you have #{Reply.count} Reply data"
  end

end
