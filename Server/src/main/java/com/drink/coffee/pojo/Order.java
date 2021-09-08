package com.drink.coffee.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.*;

import java.util.Date;
import java.util.List;

@Data
@AllArgsConstructor
@EqualsAndHashCode
@NoArgsConstructor
@ToString
@TableName(value = "orders")
public class Order{
    @TableId(value = "order_id", type = IdType.AUTO)
    private Integer orderId;
    @TableField(value = "user_id")
    private Integer userId;
    @TableField(exist = false)
    private String userName;
    @TableField(value = "order_money")
    private double orderMoney;
    @TableField(value = "order_status")
    private int orderStatus;
    @TableField(value = "order_date")
    private Date orderDate;
    @TableField(exist = false)
    private List<OrderDetail> orderCoffees;

    /**
     * 已接单
     */
    public static int ORDER_RECEIVED = 0;
    /**
     * 未接单
     */
    public static int ORDER_NON_RECEIVED = 1;

    /**
     * 已退单
     */
    public static int ORDER_RETURN = 2;

    /**
     * 已完成
     */
    public static int ORDER_FINISH = 3;
}
