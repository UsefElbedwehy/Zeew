package com.example.zeew_android
import androidx.compose.foundation.pager.HorizontalPager
import androidx.compose.foundation.pager.rememberPagerState
import androidx.compose.foundation.pager.PagerDefaults
import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.lazy.LazyRow
import androidx.compose.foundation.lazy.grid.GridCells
import androidx.compose.foundation.lazy.grid.LazyVerticalGrid
import androidx.compose.foundation.lazy.grid.items
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.draw.shadow
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.navigation.NavController
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import androidx.compose.foundation.pager.HorizontalPager
import androidx.compose.foundation.pager.rememberPagerState

import androidx.compose.foundation.layout.PaddingValues
import androidx.navigation.compose.*

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            FoodDeliveryApp()
        }
    }
}

@Composable
fun FoodDeliveryApp() {
    val navController = rememberNavController()
    NavHost(navController = navController, startDestination = "home") {
        composable("home") {
            HomeScreen(navController = navController)
        }
        composable("cart") {
            CartScreen()
        }
        // Add other screens like "details/{id}" if needed
    }
}

@Composable
fun HomeScreen(navController: NavController) {
    var showCart by remember { mutableStateOf(false) }
    var currentPage by remember { mutableStateOf(0) }
    var searchText by remember { mutableStateOf("") }
    var selectedCategory by remember { mutableStateOf(FoodCategory.Pizza) }

    val restaurants = listOf(
        Restaurant("Pizza Place", R.drawable.pizza, FoodCategory.Pizza, 4.5f, 120, "10% OFF"),
        Restaurant("Burger Joint", R.drawable.burger, FoodCategory.Burger, 4.2f, 90, null),
        Restaurant("Sushi Spot", R.drawable.pasta2, FoodCategory.Sushi, 4.8f, 50, "Free Delivery")
    )

    if (showCart) {
        LaunchedEffect(Unit) {
            navController.navigate("cart")
            showCart = false
        }
    }

    Column(modifier = Modifier.fillMaxSize().padding(8.dp)) {
        HeaderSection(onCartClick = { showCart = true })
        SearchBar(searchText = searchText, onSearchTextChange = { searchText = it })
        CategoriesSection(selectedCategory = selectedCategory, onCategorySelected = { selectedCategory = it })
        FeaturedSection(featuredRestaurants = restaurants, currentPage = currentPage, onPageChange = { currentPage = it })
        RestaurantsSection(restaurants = restaurants.filter { it.category == selectedCategory })
    }
}

@Composable
fun HeaderSection(onCartClick: () -> Unit) {
    Row(
        modifier = Modifier
            .fillMaxWidth()
            .padding(16.dp),
        horizontalArrangement = Arrangement.SpaceBetween
    ) {
        Icon(Icons.Default.Person, contentDescription = null, tint = Color.Green)

        Column(horizontalAlignment = Alignment.CenterHorizontally) {
            Text("Your Location", style = MaterialTheme.typography.headlineSmall, color = Color.Gray)
            Row {
                Icon(Icons.Default.LocationOn, contentDescription = null, tint = Color.Green)
                Text("Savar, Dhaka", style = MaterialTheme.typography.bodyMedium)
            }
        }

        IconButton(onClick = onCartClick) {
            BadgedBox(badge = { Badge { Text("3") } }) {
                Icon(Icons.Default.ShoppingCart, contentDescription = null)
            }
        }
    }
}
@Composable
fun SearchBar(searchText: String, onSearchTextChange: (String) -> Unit) {
    TextField(
        value = searchText,
        onValueChange = onSearchTextChange,
        leadingIcon = { Icon(Icons.Default.Search, contentDescription = null) },
        trailingIcon = { Icon(Icons.Default.Call, contentDescription = null) },
        placeholder = { Text("Search") },
        colors = TextFieldDefaults.colors(
            unfocusedContainerColor = Color.Green,
            focusedContainerColor = Color.Green
        ),
        modifier = Modifier
            .fillMaxWidth()
            .padding(16.dp)
            .clip(RoundedCornerShape(40.dp))
    )
}
@Composable
fun CategoriesSection(selectedCategory: FoodCategory, onCategorySelected: (FoodCategory) -> Unit) {
    LazyRow(
        contentPadding = PaddingValues(horizontal = 16.dp),
        horizontalArrangement = Arrangement.spacedBy(16.dp)
    ) {
        items(FoodCategory.values()) { category ->
            CategoryButton(
                category = category,
                isSelected = category == selectedCategory,
                onClick = { onCategorySelected(category) }
            )
        }
    }
}
@Composable
fun FeaturedSection(
    featuredRestaurants: List<Restaurant>,
    currentPage: Int,
    onPageChange: (Int) -> Unit
) {
    val pagerState = rememberPagerState(initialPage = 0, pageCount = { featuredRestaurants.size })

    Column {
        Text("Today's Special", style = MaterialTheme.typography.bodySmall, modifier = Modifier.padding(16.dp))

        HorizontalPager(
            state = pagerState,
            modifier = Modifier.height(200.dp)
        ) { page ->
            FeaturedRestaurantCard(restaurant = featuredRestaurants[page])
        }

        Row(
            horizontalArrangement = Arrangement.Center,
            modifier = Modifier.fillMaxWidth().padding(top = 8.dp)
        ) {
            repeat(featuredRestaurants.size) { index ->
                val color = if (index == pagerState.currentPage) Color.Green else Color.Green.copy(alpha = 0.3f)
                Box(
                    modifier = Modifier
                        .size(8.dp)
                        .background(color, shape = CircleShape)
                        .clickable { onPageChange(index) }
                )
            }
        }
    }
}

@Composable
fun FeaturedRestaurantCard(restaurant: Restaurant) {
    Card(
        modifier = Modifier
            .padding(8.dp)
            .fillMaxWidth(),
        elevation = CardDefaults.cardElevation(defaultElevation = 4.dp)
    ) {
        Column(modifier = Modifier.padding(16.dp)) {
            Text(text = restaurant.name, style = MaterialTheme.typography.titleLarge)
            Text(text = restaurant.name, style = MaterialTheme.typography.bodyMedium)
        }
    }
}
@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun YourComposable() {
    // Your code using experimental Material3 components
}

@Composable
fun RestaurantsSection(restaurants: List<Restaurant>) {
    Column(modifier = Modifier.padding(16.dp)) {
        Row(horizontalArrangement = Arrangement.SpaceBetween, modifier = Modifier.fillMaxWidth()) {
            Text("Restaurants", style = MaterialTheme.typography.bodySmall)
            TextButton(onClick = { /* View All */ }) {
                Text("View All", color = Color.Gray)
            }
        }

        LazyVerticalGrid(
            columns = GridCells.Fixed(2),
            contentPadding = PaddingValues(vertical = 8.dp),
            verticalArrangement = Arrangement.spacedBy(16.dp),
            horizontalArrangement = Arrangement.spacedBy(16.dp)
        ) {
            items(restaurants) { restaurant ->
                RestaurantCard(restaurant = restaurant)
            }
        }
    }
}
@Composable
fun CategoryButton(category: FoodCategory, isSelected: Boolean, onClick: () -> Unit) {
    Column(
        modifier = Modifier
            .width(70.dp)
            .padding(horizontal = 10.dp, vertical = 25.dp)
            .background(if (isSelected) Color.Green else Color.LightGray, shape = RoundedCornerShape(10.dp))
            .clickable(onClick = onClick),
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        Icon(category.icon, contentDescription = null, tint = if (isSelected) Color.White else Color.Black)
        Text(category.name, style = MaterialTheme.typography.bodySmall, color = if (isSelected) Color.White else Color.Black)
    }
}
@Composable
fun RestaurantCard(restaurant: Restaurant) {
    Column(
        modifier = Modifier
            .width(170.dp)
            .background(Color.White, shape = RoundedCornerShape(12.dp))
            .padding(bottom = 12.dp)
            .shadow(8.dp, shape = RoundedCornerShape(12.dp))
    ) {
        Box {
            Image(painterResource(id = restaurant.imageRes), contentDescription = null, modifier = Modifier.height(120.dp).fillMaxWidth())
            if (restaurant.discount != null) {
                Text(
                    text = restaurant.discount,
                    color = Color.White,
                    modifier = Modifier
                        .align(Alignment.TopEnd)
                        .padding(8.dp)
                        .background(Color.Green, shape = RoundedCornerShape(20.dp))
                        .padding(horizontal = 8.dp, vertical = 4.dp)
                )
            }
        }
        Text(restaurant.name, style = MaterialTheme.typography.bodyMedium, modifier = Modifier.padding(horizontal = 8.dp))
        Button(onClick = { /* Add to cart */ }, modifier = Modifier.align(Alignment.CenterHorizontally)) {
            Text("Add to cart")
        }
    }
}
data class Restaurant(
    val name: String,
    val imageRes: Int,
    val category: FoodCategory,
    val rating: Float,
    val ratingCount: Int,
    val discount: String?
)

enum class FoodCategory(val icon: ImageVector) {
    Pizza(Icons.Default.Face),
    Burger(Icons.Default.Home),
    Sushi(Icons.Default.Call)
    // Add more categories as needed
}

@Preview(showBackground = true)
@Composable
fun HomeScreenPreview() {
    val navController = rememberNavController()
    HomeScreen(navController = navController)
}
@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun CartScreen() {
    Scaffold(
        topBar = {
            TopAppBar(
                title = { Text("Your Cart") }
            )
        }
    ) { innerPadding ->
        Box(
            modifier = Modifier
                .fillMaxSize()
                .padding(innerPadding)
        ) {
            Text(
                text = "Cart Items Here",
                style = MaterialTheme.typography.bodyLarge,
                modifier = Modifier.align(Alignment.Center)
            )
        }
    }
}

