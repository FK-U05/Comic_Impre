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
