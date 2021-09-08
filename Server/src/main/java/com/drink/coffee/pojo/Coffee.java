package com.drink.coffee.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.*;

@Data
@AllArgsConstructor
@EqualsAndHashCode
@NoArgsConstructor
@ToString
public class Coffee {
    @TableId(value = "coffee_id", type = IdType.AUTO)
    private Integer coffeeId;
    @TableField(value = "coffee_name")
    private String coffeeName;
    @TableField(value = "coffee_price")
    private Double coffeePrice;
    @TableField(value = "coffee_information")
    private String coffeeInformation;
    @TableField(value = "coffee_url")
    private String coffeeUrl;
    @TableField(value = "coffee_status")
    private Integer coffeeStatus;
    @TableField(value = "coffee_sugar")
    private Integer coffeeSugar;
    @TableField(value = "coffee_temperature")
    private Integer coffeeTemperature;
    @TableField(value = "coffee_size")
    private Integer coffeeSize;
}
