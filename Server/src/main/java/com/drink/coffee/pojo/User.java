package com.drink.coffee.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.*;

@Data
@AllArgsConstructor
@EqualsAndHashCode
@NoArgsConstructor
@ToString
public class User {
    @TableId(value = "user_id", type = IdType.AUTO)
    private Integer userId;
    private String userName;
    private String password;
    private String sex;
    private String account;
    private Integer status;
    private String phone;
}
