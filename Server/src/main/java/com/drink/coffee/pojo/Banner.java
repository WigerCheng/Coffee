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
public class Banner {
    @TableId(value = "banner_id", type = IdType.AUTO)
    private Integer bannerId;
    @TableField("banner_img")
    private String bannerImg;
}
