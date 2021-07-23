void drawX() {
    char* video_memory = (char*) 0xb8000;
    *video_memory = 'X';
}

void main() {
    drawX();
}
