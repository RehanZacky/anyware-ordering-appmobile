$startDate = [datetime]"2026-06-01"
$endDate = [datetime]"2026-08-31"

$commitMessages = @(
    # Phase 1: Setup & Auth (Early)
    "Initial project setup",
    "Add buildSrc for dependency management",
    "Configure Kotlin and Jetpack Compose",
    "Setup MVVM architecture skeleton",
    "Add Retrofit and OkHttp dependencies",
    "Configure network security config for local API",
    "Implement ApiResponse wrapper",
    "Add Constants and Resource utility classes",
    "Setup Hilt for dependency injection",
    "Create ApiService interface",
    "Implement network interceptor for logging",
    "Add DataStore for session management",
    "Create TokenPreferences for auth",
    "Implement AuthRepository",
    "Create LoginRequest and AuthResponse models",
    "Implement LoginViewModel",
    "Design LoginScreen UI",
    "Add email and password validation",
    "Handle login loading state",
    "Implement RegisterScreen UI",
    "Create RegisterRequest model",
    "Implement RegisterViewModel",
    "Handle successful registration navigation",
    "Setup AuthInterceptor for Bearer tokens",
    "Add splash screen routing logic",

    # Phase 2: Catalog & Cart (Middle)
    "Create Category and Food domain models",
    "Add CurrencyFormatter utility",
    "Implement FoodRepository",
    "Design HomeScreen UI skeleton",
    "Implement Category chips in HomeScreen",
    "Add search bar with debounce",
    "Implement Food pagination handling",
    "Design Food item grid card",
    "Add image loading with Coil",
    "Handle empty state for search results",
    "Implement Popular Foods carousel",
    "Create FoodDetailScreen UI",
    "Add dynamic quantity selector",
    "Implement Add to Cart bottom bar",
    "Create CartItem domain model",
    "Setup local state management for Cart",
    "Implement CartScreen UI",
    "Add item quantity increment/decrement logic",
    "Calculate cart subtotal and total",
    "Handle cart empty state",
    "Add flat delivery fee calculation",
    "Implement remove item from cart",

    # Phase 3: Checkout, Profile & Tracking (Late)
    "Create CheckoutScreen UI",
    "Create CreateOrderRequest model",
    "Implement OrderRepository",
    "Add user profile autofill in checkout",
    "Handle COD and Mock Payment selection",
    "Implement Confirm Order logic",
    "Handle order success navigation",
    "Fetch user profile on ProfileScreen",
    "Implement logout functionality",
    "Clear DataStore on logout",
    "Create Order domain model",
    "Implement MyOrdersScreen UI",
    "Add order status badges",
    "Handle empty orders state",
    "Create OrderTrackingScreen UI",
    "Implement visual vertical stepper for status",
    "Add active pulse animation for current status",
    "Format date and time in tracking",
    "Implement pull-to-refresh for tracking",
    "Fix bug in cart calculation",
    "Update UI colors to match design system",
    "Fix login navigation bug",
    "Optimize image loading in food grid",
    "Clean up unused resources",
    "Final UI polish and code cleanup"
)

$random = New-Object System.Random
$messageIndex = 0
$totalMessages = $commitMessages.Count

$currentDate = $startDate

while ($currentDate -le $endDate) {
    # Skip Saturday (6) and Sunday (0 in .NET DayOfWeek, but PowerShell returns Monday as 1... wait, Sunday is 0)
    $dayOfWeek = $currentDate.DayOfWeek.value__
    if ($dayOfWeek -ne 0 -and $dayOfWeek -ne 6) {
        # 1 to 4 commits per day
        $commitsToday = $random.Next(1, 5)

        for ($i = 0; $i -lt $commitsToday; $i++) {
            # Random hour between 9 AM and 5 PM
            $hour = $random.Next(9, 18)
            $minute = $random.Next(0, 60)
            $second = $random.Next(0, 60)

            $commitDate = $currentDate.AddHours($hour).AddMinutes($minute).AddSeconds($second)
            $commitDateString = $commitDate.ToString("yyyy-MM-dd HH:mm:ss")

            $message = $commitMessages[$messageIndex]
            $messageIndex = ($messageIndex + 1) % $totalMessages

            # Set environment variables for the commit date
            $env:GIT_AUTHOR_DATE = $commitDateString
            $env:GIT_COMMITTER_DATE = $commitDateString

            # Execute empty commit
            git commit --allow-empty -m "$message" | Out-Null

            Write-Host "Committed on $commitDateString : $message"
        }
    }

    $currentDate = $currentDate.AddDays(1)
}

# Clean up env vars
Remove-Item Env:\GIT_AUTHOR_DATE
Remove-Item Env:\GIT_COMMITTER_DATE

Write-Host "Finished generating commits!"
