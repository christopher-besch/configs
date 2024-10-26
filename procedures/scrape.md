```
wget https://landkartenarchiv.de/landkartensammlungen/stadtplansammlung/plan_der_stadt_warschau_1940/TileGroup{0..10}/5-{0..27}-{0..29}.jpg
mmv '5-*-*.jpg' '#2_#1.jpg'
# this ignores the bottom and right edge, those images are smaller and cause issues with montage
montage -mode concatenate -tile 27x29 {0..28}_{0..26}.jpg out.jpg
```
