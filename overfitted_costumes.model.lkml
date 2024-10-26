connection: "Overfitted Costumes"

# include all the views
include: "*.view"


explore: inventory_items {}

explore: order_items {
  description: "Main base explore for looking at orders and order details"

  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: customers {
    type: left_outer
    sql_on: ${order_items.user_id} = ${customers.user_id} ;;
    relationship: many_to_one
  }

  
}

explore: orders {
  join: customers {
    type: left_outer
    sql_on: ${orders.user_id} = ${customers.user_id} ;;
    relationship: many_to_one
  }
}

explore: customers {}
