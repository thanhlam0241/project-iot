package com.example.demo.Configurations;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.connection.RedisPassword;
import org.springframework.data.redis.connection.RedisStandaloneConfiguration;
import org.springframework.data.redis.connection.jedis.JedisConnectionFactory;
import org.springframework.data.redis.connection.lettuce.LettuceConnectionFactory;
import org.springframework.data.redis.core.RedisTemplate;

import java.time.Duration;

@Configuration
public class RedisConfig {
    @Value("${spring.redis.host}")
    private String host;
    @Value("${spring.redis.port}")
    private int port;
    @Value("${spring.redis.database}")
    private int database;
    @Value("${spring.redis.username}")
    private String username;
    @Value("${spring.redis.password}")
    private String password;
    @Bean
    public LettuceConnectionFactory redisConnectionFactory() {
        // Tạo Standalone Connection tới Redis
        RedisStandaloneConfiguration configuration = new RedisStandaloneConfiguration();
        configuration.setHostName(host);
        configuration.setPort(port);
        configuration.setUsername(username);
        configuration.setPassword(password);
        configuration.setDatabase(database);
        return new LettuceConnectionFactory(configuration);
    }


    @Bean
    public RedisTemplate<?, ?> redisTemplate(RedisConnectionFactory factory) {
//        RedisConnectionFactory factory = redisConnectionFactory();
        RedisTemplate<?, ?> template = new RedisTemplate<>();
        template.setConnectionFactory(factory);

        return template;
    }

}
