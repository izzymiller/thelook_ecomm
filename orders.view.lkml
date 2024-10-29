view: orders {
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: traffic_source {
    type: string
    sql: ${TABLE}.traffic_source ;;
  }

  dimension: user_id {
    type: number
    # hidden: ys
    sql: ${TABLE}.user_id ;;
  }

  dimension: total_amount_of_order_usd {
    type: number
    value_format_name: decimal_2
    sql:
      (SELECT SUM(order_items.sale_price)
      FROM order_items
      WHERE order_items.order_id = ${id}) ;;
  }

  dimension: total_cost_of_order {
    type: number
    value_format_name: decimal_2
    sql:
        (SELECT SUM(inventory_items.cost)
        FROM order_items
        LEFT JOIN inventory_items ON order_items.inventory_item_id = inventory_items.id
        WHERE order_items.order_id = ${id}) ;;
  }

  dimension: order_profit {
    type: number
    value_format_name: decimal_2
    sql: ${total_amount_of_order_usd} - ${total_cost_of_order} ;;
  }


  measure: count {
    type: count
    drill_fields: [id, customers.last_name, customers.first_name, customers.id, order_items.count]
  }

  measure: first_purchase_count {
    type: count
    drill_fields: [id, created_time, customers.name, total_cost_of_order]

  }

  measure: average_order_profit {
    type: average
    value_format: "$#.00"
    sql: ${order_profit} ;;
  }
}
