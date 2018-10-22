namespace :dev do
  # 請先執行 rails dev:fake_user，可以產生 20 個資料完整的 User 紀錄
  # 其他測試用的假資料請依需要自行撰寫

  task all: [:fake_user, :fake_cate, :fake_post, :fake_reply, :fake_caterelate]

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

  task fake_cate: :environment do
    Category.destroy_all
    5.times do |i|

      cate = Category.new(
        name: "Category#{i}",
      )

      cate.save!
    end
    puts "now you have #{Category.count} categories data"
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
    puts "now you have #{Post.count} posts data"
  end

  task fake_caterelate: :environment do
    Caterelate.destroy_all 
    Post.all.each do |post|
      cates = Category.all.sample(rand(1..3))
      cates.each do |cate|
        Caterelate.create!( 
          category_id: cate.id,
          post_id: post.id 
        )
      end
    end
    puts "now you have #{Caterelate.count} Caterelates data"
  end

  task fake_reply: :environment do
    Reply.destroy_all
    Post.all.each do |post|
      rand(30).times do
        post.replies.create!(
          comment: FFaker::Lorem.paragraph,
          user_id: User.all.sample.id
        )
      end
    end
    puts "now you have #{Reply.count} Reply data"
  end

end
