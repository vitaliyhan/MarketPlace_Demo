package com.example.mktplace.services;

import com.example.mktplace.models.Image;
import com.example.mktplace.models.Product;
import com.example.mktplace.models.User;
import com.example.mktplace.models.enums.Role;
import com.example.mktplace.repositories.ProductRepository;
import com.example.mktplace.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.security.Principal;
import java.util.List;
import java.util.Arrays;

@Service
@Slf4j
@RequiredArgsConstructor
public class ProductService {
    private final ProductRepository productRepository;
    private final UserRepository userRepository;

    public List<Product> listProducts(String searchTerm) {
        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            return productRepository.findByTitleOrDescriptionContainingIgnoreCase(searchTerm.trim());
        }
        return productRepository.findAll();
    }

    public void saveProduct(Principal principal, Product product, MultipartFile file1, MultipartFile file2, MultipartFile file3) throws IOException {
        product.setUser(getUserByPrincipal(principal));
        Image image1;
        Image image2;
        Image image3;

        if (file1.getSize() != 0) {
            image1 = toImageEntity(file1);
            image1.setPreviewImage(true);
            product.addImageToProduct(image1);
        }
        if (file2.getSize() != 0) {
            image2 = toImageEntity(file1);
            product.addImageToProduct(image2);
        }
        if (file3.getSize() != 0) {
            image3 = toImageEntity(file1);
            product.addImageToProduct(image3);
        }

        log.info("Saving new Product. Title: {}; email: {}", product.getTitle(), product.getUser().getEmail());
        Product productFromDb = productRepository.save(product);
        productFromDb.setPreviewImageId(productFromDb.getImages().get(0).getId());
        productRepository.save(product);
    }

    public User getUserByPrincipal(Principal principal) {
        if (principal == null) {
            return new User();
        }
        return userRepository.findByEmail(principal.getName());
    }


    private Image toImageEntity(MultipartFile file) throws IOException {
        Image image = new Image();
        image.setName(file.getName());
        image.setOriginalFileName(file.getOriginalFilename());
        image.setContentType(file.getContentType());
        image.setSize(file.getSize());
        image.setBytes(file.getBytes());
        return image;
    }


    public void deleteProduct(User user, Long id) {
        Product product = productRepository.findById(id)
                .orElse(null);
        if (product != null) {
            if (product.getUser().getId().equals(user.getId())) {
                productRepository.delete(product);
                log.info("Product with id = {} was deleted", id);
            } else {
                log.error("User: {} haven't this product with id = {}", user.getEmail(), id);
            }
        } else {
            log.error("Product with id = {} is not found", id);
        }
    }

    public Product getProductById(Long id) {
        return productRepository.findById(id).orElse(null);
    }

    public void createDummyData() {
        // Создаем тестовых пользователей если их нет
        User dummyUser1 = userRepository.findByEmail("test@example.com");
        if (dummyUser1 == null) {
            dummyUser1 = new User();
            dummyUser1.setEmail("test@example.com");
            dummyUser1.setName("Тестовый Пользователь");
            dummyUser1.setPhoneNumber("+7(999)123-45-67");
            dummyUser1.setActive(true);
            dummyUser1.setPassword("$2a$08$nEv4tL9p9qZGJGJGJGJGJGJGJGJGJGJGJGJGJGJGJGJGJGJGJGJGJ"); // password
            dummyUser1.getRoles().add(Role.ROLE_USER);
            userRepository.save(dummyUser1);
        }

        User dummyUser2 = userRepository.findByEmail("seller@example.com");
        if (dummyUser2 == null) {
            dummyUser2 = new User();
            dummyUser2.setEmail("seller@example.com");
            dummyUser2.setName("Продавец Товаров");
            dummyUser2.setPhoneNumber("+7(999)987-65-43");
            dummyUser2.setActive(true);
            dummyUser2.setPassword("$2a$08$nEv4tL9p9qZGJGJGJGJGJGJGJGJGJGJGJGJGJGJGJGJGJGJGJGJGJ"); // password
            dummyUser2.getRoles().add(Role.ROLE_USER);
            userRepository.save(dummyUser2);
        }

        // Списки для генерации разнообразных товаров
        List<String> titles = Arrays.asList(
            "iPhone 14 Pro Max 256GB", "MacBook Pro 16 M2", "Samsung Galaxy S23 Ultra",
            "Sony PlayStation 5", "Nintendo Switch OLED", "Xbox Series X",
            "Apple Watch Series 8", "AirPods Pro 2", "iPad Air 5", "Samsung Galaxy Tab S8",
            "Dell XPS 13", "HP Pavilion Gaming", "ASUS ROG Strix", "Lenovo ThinkPad X1",
            "Canon EOS R5", "Nikon Z6 II", "GoPro HERO 11", "DJI Mavic Air 2",
            "Bose QuietComfort 45", "Sony WH-1000XM5"
        );

        List<String> descriptions = Arrays.asList(
            "Отличный смартфон в идеальном состоянии, полный комплект",
            "Мощный ноутбук для работы и игр, отличная производительность",
            "Флагманский смартфон с превосходной камерой и производительностью",
            "Игровая консоль нового поколения с поддержкой 4K",
            "Портативная игровая консоль с отличным экраном",
            "Мощная игровая консоль от Microsoft",
            "Умные часы с множеством функций для здоровья и фитнеса",
            "Беспроводные наушники с активным шумоподавлением",
            "Планшет для работы и развлечений",
            "Профессиональный планшет для творчества",
            "Ультрабук премиум класса для бизнеса",
            "Игровой ноутбук с дискретной графикой",
            "Геймерский ноутбук с RGB подсветкой",
            "Бизнес-ноутбук с высокой надежностью",
            "Профессиональная зеркальная камера",
            "Беззеркальная камера для профессиональной съемки",
            "Экшн-камера для активного отдыха",
            "Дрон для аэрофотосъемки",
            "Беспроводные наушники премиум класса",
            "Наушники с лучшим шумоподавлением"
        );

        List<String> cities = Arrays.asList(
            "Москва", "Санкт-Петербург", "Екатеринбург", "Новосибирск", "Казань",
            "Нижний Новгород", "Челябинск", "Самара", "Омск", "Ростов-на-Дону",
            "Уфа", "Красноярск", "Воронеж", "Пермь", "Волгоград", "Краснодар"
        );

        List<Integer> prices = Arrays.asList(
            85000, 180000, 95000, 45000, 35000, 50000, 25000, 20000, 45000, 55000,
            120000, 80000, 150000, 90000, 280000, 160000, 35000, 65000, 25000, 35000
        );

        // Создаем 20 товаров
        for (int i = 0; i < 20; i++) {
            Product product = new Product();
            product.setTitle(titles.get(i % titles.size()));
            product.setDescription(descriptions.get(i % descriptions.size()));
            product.setPrice(prices.get(i % prices.size()));
            product.setCity(cities.get(i % cities.size()));

            // Чередуем пользователей для товаров
            if (i % 2 == 0) {
                product.setUser(dummyUser1);
            } else {
                product.setUser(dummyUser2);
            }

            productRepository.save(product);
        }

        log.info("Created 20 dummy products in database");
    }
}
