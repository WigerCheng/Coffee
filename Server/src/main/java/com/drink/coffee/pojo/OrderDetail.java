package com.drink.coffee.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.*;

@Data
@RequiredArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode
@NoArgsConstructor
@ToString
@TableName(value = "orderdetail")
public class OrderDetail {
    @TableId(value = "detail_id", type = IdType.AUTO)
    private Integer detailId;
    @NonNull
    @TableField(value = "detail_coffee_id")
    private Integer coffeeId;
    @NonNull
    @TableField(value = "detail_order_id")
    private Integer orderId;
    @TableField(value = "detail_quantity")
    private Integer quantity;
    @TableField(value = "detail_sugar")
    private Integer coffeeSugar;
    @TableField(value = "detail_temperature")
    private Integer coffeeTemperature;
    @TableField(value = "detail_size")
    private Integer coffeeSize;
    @TableField(exist = false)
    private double coffeePrice;
    @TableField(exist = false)
    private String coffeeUrl;
    @TableField(exist = false)
    private String coffeeName;
}
