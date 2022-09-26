# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#ジャンル名デフォルト
Genre.create([
    { genre_name: 'ギャグ'},
    { genre_name: 'ファンタジー'},
    { genre_name: '恋愛'},
    { genre_name: 'スポーツ'},
    { genre_name: 'ミステリー'},
    { genre_name: 'グルメ'},
    { genre_name: '学園'},
    { genre_name: 'バトルアクション'},
    { genre_name: 'SF'}
])

#タグ名デフォルト
Tag.create([
    { tag_name: '泣ける'},
    { tag_name: '爆笑'},
    { tag_name: '胸キュン'},
    { tag_name: 'しんどい'},
    { tag_name: 'かわいい'},
    { tag_name: '衝撃の展開'},
    { tag_name: '切ない'}
])

#管理者用ログイン情報
Admin.create!(
    email: 'admin@admin',
    password: '123456',
)

#テストデータ
Customer.create!(
    name: 'customer1',
    email: 'customer1@customer1',
    password: 'customer1',
    password_confirmation: 'customer1',
    profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("./app/assets/images/sample_customer1.jpg")),filename: "sample_customer1.jpg"))

Customer.create!(
    name: 'customer2',
    email: 'customer2@customer2',
    password: 'customer2',
    password_confirmation: 'customer2',
    profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("./app/assets/images/sample_customer2.jpg")),filename: "sample_customer2.jpg"))

Customer.create!(
    name: 'customer3',
    email: 'customer3@customer3',
    password: 'customer3',
    password_confirmation: 'customer3',
    profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("./app/assets/images/sample_customer3.jpg")),filename: "sample_customer3.jpg"))

Comic.create!(
    customer_id: 1,
    company: "集英社",
    title: "ハイキュー！！",
    body: "高校生バレーの漫画です。バレーのルールを全く知らない人にもわかりやすくルールと魅力を解説してくれているので、すぐ物語の魅力に引き込まれます。誰が読んでも楽しめるバレー漫画だと思います。",
    name: "古舘春一",
    release_date: '2012-06-09')

Comic.create!(
    customer_id: 2,
    company: "KADOKAWA",
    title: "ダンジョン飯",
    body: "ドラゴンに食べられてしまった妹をすぐに助けに行くため、迷宮の中にいる魔物を食べて行くことにしたパーティーの話です。現実にない食糧を調理していく様は不思議と見入ってしまいます。",
    name: "九井諒子",
    release_date: '2015-01-27')

Comic.create!(
    customer_id: 3,
    company: "白泉社",
    title: "赤髪の白雪姫",
    body: "赤い髪を持つ薬剤師の主人公・白雪が、ある日隣の国の王子様と出会う王宮ファンタジーものです。主人公の白雪がとてもかっこいい女の子なので見ていてとても爽快です！",
    name: "あきづき空太",
    release_date: '2007-12-05')

