## usersテーブル

| Column                       | Type    | Options                   |
| ---------------------------- | ------- | ------------------------- |
| nickname                     | string  | null: false, unique: true |
| email                        | string  | null: false, unique: true |
| encrypted_password           | string  | null: false               |
| last_name                    | string  | null: false               |
| first_name                   | string  | null: false               |
| last_name_pseudonym_reading  | string  | null: false               |
| first_name_pseudonym_reading | string  | null: false               |
| birthday_year                | integer | null: false               |
| birthday_month               | integer | null: false               |
| birthday_day                 | integer | null: false               |

### Association
- has_many :items
- has_many :purchase_records


## itemsテーブル

| Column           | Type        | Options                        |
| ---------------- | ----------- | ------------------------------ |
| name             | string      | null: false                    |
| content          | text        | null: false                    |
| category         | string      | null: false                    |
| price            | integer     | null: false                    |
| quality          | string      | null: false                    |
| shipping_charge  | integer     | null: false                    |
| shipment_source  | string      | null: false                    |
| date_shipment    | string      | null: false                    |
| user             | references  | null: false, foreign_key: true |

### Association
- has_one :purchase_record
- belongs_to :user


## purchase_recordsテーブル

| Column           | Type        | Options                        |
| ---------------- | ----------- | ------------------------------ |
| user             | references  | null: false, foreign_key: true |
| item             | references  | null: false, foreign_key: true |

### Association
- has_one :shipping_address
- belongs_to :item
- belongs_to :user


## shipping_addressesテーブル

| Column           | Type        | Options                        |
| ---------------- | ----------- | ------------------------------ |
| postal_code      | integer     | null: false                    |
| prefectures      | string      | null: false                    |
| municipality     | string      | null: false                    |
| address          | string      | null: false                    |
| building_name    | string      | null: false                    |
| telephone_number | integer     | null: false                    |

### Association
- belongs_to :purchase_record