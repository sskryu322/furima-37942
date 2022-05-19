## usersテーブル

| Column                       | Type    | Options                   |
| ---------------------------- | ------- | ------------------------- |
| nickname                     | string  | null: false               |
| email                        | string  | null: false, unique: true |
| encrypted_password           | string  | null: false               |
| last_name                    | string  | null: false               |
| first_name                   | string  | null: false               |
| last_name_pseudonym_reading  | string  | null: false               |
| first_name_pseudonym_reading | string  | null: false               |
| birthday                     | date    | null: false               |

### Association
- has_many :items
- has_many :purchase_records


## itemsテーブル

| Column             | Type        | Options                        |
| ------------------ | ----------- | ------------------------------ |
| name               | string      | null: false                    |
| content            | text        | null: false                    |
| category_id        | integer     | null: false                    |
| price              | integer     | null: false                    |
| quality_id         | integer     | null: false                    |
| shipping_charge_id | integer     | null: false                    |
| shipment_source_id | integer     | null: false                    |
| date_shipment_id   | integer     | null: false                    |
| user               | references  | null: false, foreign_key: true |

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

| Column             | Type        | Options                        |
| ------------------ | ----------- | ------------------------------ |
| postal_code        | string      | null: false                    |
| shipment_source_id | integer     | null: false                    |
| municipality       | string      | null: false                    |
| address            | string      | null: false                    |
| building_name      | string      | null: true                     |
| telephone_number   | string      | null: false                    |
| purchase_record    | references  | null: false, foreign_key: true |

### Association
- belongs_to :purchase_record