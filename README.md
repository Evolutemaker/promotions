# Promotions - Мобильное приложение акций

Мобильное приложение на Flutter для просмотра акций с интеграцией Supabase и поддержкой офлайн-режима.

## Описание проекта

Функционал:

- **Главный экран** с отображением списка акций
- **Экран деталей** с подробной информацией об акции
- **Интеграция с Supabase** для получения данных
- **Офлайн-режим** с локальным хранением данных
- **Поиск акций** с debouncing
- **Функция "Поделиться"** для акций


## Технологический стек

### Основные зависимости

- `flutter_bloc` - управление состоянием
- `supabase_flutter` - интеграция с Supabase
- `drift` - локальная база данных
- `auto_route` - навигация
- `get_it` - dependency injection
- `share_plus` - функция "Поделиться"
- `internet_connection_checker_plus` - проверка интернет-соединения


### Архитектура

- **BLoC/Cubit** для управления состоянием
- **Repository Pattern** для работы с данными
- **Offline-first** подход с автоматическим fallback
- **Clean Architecture** с разделением слоев


## Настройка проекта

### 1. Клонирование репозитория

```bash
git clone https://github.com/Evolutemaker/promotions.git
cd promotions
```


### 2. Установка зависимостей

```bash
flutter pub get
```


### 3. Генерация кода

```bash
dart run build_runner build --delete-conflicting-outputs
```


### 4. Настройка Supabase

Создайте файл `.env` в корне проекта:

```env
SUPABASE_URL='https://atuylbjxizsegyjyeywi.supabase.co'
SUPABASE_ANON_KEY='eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImF0dXlsYmp4aXpzZWd5anlleXdpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTAxNzQwNDMsImV4cCI6MjA2NTc1MDA0M30.mLiiQCHmT3kXd0ftyK1GFYvkncSuM8XwxOKQHpUuJxg'
```


## Запуск приложения

### Для разработки

```bash
flutter run
```

### Для релиза

```bash
flutter build apk --release  # Android
flutter build ios --release  # iOS
```

## Структура проекта

```
lib/
├── config/                 # Конфигурация (Supabase, Database)
├── core/                   # Основные утилиты
│   ├── di/                # Dependency Injection
│   ├── network/           # Проверка сети
│   └── utils/             # Утилиты (Debouncer, ShareHelper)
├── cubit/                 # BLoC/Cubit для управления состоянием
├── models/                # Модели данных
├── navigation/            # Настройка навигации (AutoRoute)
├── pages/                 # Экраны приложения
│   ├── home/             # Главный экран
│   └── promotion_detail/ # Экран деталей
├── repository/           # Repository Pattern
├── services/             # Сервисы (API, Storage)
├── uikit/               # UI компоненты и темы
└── widgets/             # Переиспользуемые виджеты
```

## Требования

- Flutter SDK ≥ 3.6.2
- Dart SDK ≥ 3.6.2
- Android SDK (для Android)
- Xcode (для iOS)

<div style="text-align: center">⁂</div>


