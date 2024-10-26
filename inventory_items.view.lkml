view: inventory_items {
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: cost {
    type: number
    sql: ${TABLE}.cost ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    sql: ${TABLE}.created_at ;;
  }

  dimension: product_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.product_id ;;
  }

  dimension_group: sold {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    sql: ${TABLE}.sold_at ;;
  }

    dimension: brand {
    type: string
    sql: ${TABLE}.product_brand ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}.product_category ;;
  }

  dimension: department {
    type: string
    sql: ${TABLE}.product_department ;;
  }

  dimension: item_name {
    type: string
    sql: ${TABLE}.product_name ;;
  }

  dimension: retail_price {
    type: number
    sql: ${TABLE}.product_retail_price ;;
  }

  dimension: sku {
    type: string
    sql: ${TABLE}.sku ;;
  }

  measure: count {
    type: count
    drill_fields: [id, order_items.count]
  }
}
