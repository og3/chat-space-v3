# users

## association
has_many : messages
has_many : group_users
has_many : groups, through: group_users

## table
name :string, null: false, add_index: users, name
email :string, null: false, unique: true, add_index: users, email
password :string, null: false



# groups

## association
has_many : users, through: group_users
has_many : messages
has_many : group_users

## table
group_name :string, null: false, add_index: groups, group_name



# group_users


## association
belongs_to :user
belongs_to :group

## table
references :user, foreign_key: true, add_index: group_users, references :user
references :group, foreign_key: true, add_index: group_users, references :group



# messages

## association
belongs_to : user

## table
message :text
image :string
references :user, foreign_key: true
references :group, foreign_key: true