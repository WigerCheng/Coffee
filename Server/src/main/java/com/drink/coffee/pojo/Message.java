package com.drink.coffee.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NonNull;

@Data
@AllArgsConstructor
public class Message {
    @NonNull String content;
}
