namespace :dev do
  # 請先執行 rails dev:fake_user，可以產生 20 個資料完整的 User 紀錄
  # 其他測試用的假資料請依需要自行撰寫

  task all: [:fake_user, :fake_cate, :fake_post, :fake_reply, :fake_caterelate, :fake_collect]

  task fake_user: :environment do
    20.times do |i|
      name = FFaker::Name::first_name

      user = User.new(
        name: name,
        email: "#{name}@example.co",
        password: "12345678",
        intro: FFaker::Lorem::sentence(20),
      )

      user.save!
    end
    puts "now you have #{User.count} users data"
  end

  task fake_cate: :environment do
    Category.destroy_all
    category_list = [
      { name: "Category1" },
      { name: "Category2" },
      { name: "Category3" },
      { name: "Category4" },
      { name: "Category5" },
    ]
    category_list.each do |category|
      Category.create( name: category[:name] )
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

  task fake_collect: :environment do
    Collect.destroy_all
    @users = User.all
    @users.each do |user|
      posts = Post.all.sample(rand(1..3))
      posts.each do |post|
        Collect.create!( 
          user_id: user.id,
          post_id: post.id 
        ) 
      end     
    end
    puts "now you have #{Collect.count} collecs data"
  end

  task fake_friendship: :environment do
    Friendship.destroy_all
    @users = User.all
    @users.each do |user|
      users = @users - [user]
      1.times do |i|
        Friendship.create!(user_id: user.id, 
          friend_id: users.sample.id
        )
      end
    end
    puts "now you have #{Friendship.count} Friends data"
  end

  task fake_applyfriend: :environment do
    Applyfriend.destroy_all
    @users = User.all
    @users.each do |user|
      users = @users - [user]
      1.times do |i|
        Applyfriend.create!(user_id: user.id, 
          friend_id: users.sample.id
        )
      end
    end
    puts "now you have #{Applyfriend.count} applyfriends data"
  end

end
