package com.drink.coffee.controller;

import com.drink.coffee.pojo.Message;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.io.IOException;
import java.util.Map;
import java.util.Objects;
import java.util.concurrent.ConcurrentHashMap;

@Slf4j
@RestController
public class SseController {

    public static final Map<Integer, SseEmitter> SSE_HOLDER = new ConcurrentHashMap<>();

    @GetMapping(value = "/notification/{userId}")
    public SseEmitter emitCustomer(@PathVariable(value = "userId") int userId) {
        log.info("用户{}已连上", userId);
        SseEmitter sseEmitter = new SseEmitter(Long.MAX_VALUE);
        SSE_HOLDER.remove(userId);
        SSE_HOLDER.put(userId, sseEmitter);
        return sseEmitter;
    }

    private static final SseEmitter sseEmitter = new SseEmitter(Long.MAX_VALUE);

    @GetMapping(value = "/notification/manager")
    public SseEmitter emitManager() {
        log.info("后台管理已连上");
        return sseEmitter;
    }

    /**
     * 通过sessionId获取对应的客户端进行推送消息
     */
    public static void pushCustomerMessage(int userId, String content) {
        SseEmitter emitter = SseController.SSE_HOLDER.get(userId);
        if (Objects.nonNull(emitter)) {
            try {
                log.info("发送用户{}信息{}", userId, content);
                emitter.send(new Message(content), MediaType.APPLICATION_JSON);
            } catch (IOException | IllegalStateException e) {
                SseController.SSE_HOLDER.remove(userId);
            }
        }
    }

    /**
     * 通过sessionId获取对应的后台端进行推送消息
     */
    public static void pushManagerMessage(String content) {
        try {
            log.info("发送后台信息{}", content);
            sseEmitter.send(new Message(content), MediaType.APPLICATION_JSON);
        } catch (IOException | IllegalStateException e) {
            log.error(e.getMessage());
        }
    }
}
