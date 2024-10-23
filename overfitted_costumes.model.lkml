connection: "Overfitted Costumes"

# include all the views
include: "*.view"


explore: inventory_items {
  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
}

explore: order_items {
  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: orders {
    type: left_outer
    sql_on: ${order_items.order_id} = ${orders.id} ;;
    relationship: many_to_one
  }

  join: customers {
    type: left_outer
    sql_on: ${orders.user_id} = ${customers.id} ;;
    relationship: many_to_one
  }
}

explore: orders {
  join: customers {
    type: left_outer
    sql_on: ${orders.user_id} = ${customers.id} ;;
    relationship: many_to_one
  }
}

explore: customers {}