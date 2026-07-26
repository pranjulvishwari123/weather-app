from django.shortcuts import render
from django.http import HttpResponse
import datetime
import requests

# Create your views here.
def home(request):
    if request.method=="POST":
        city = request.POST.get('city')
    else:
        city = "noida"
    url=f'https://api.openweathermap.org/data/2.5/weather?q={city}&appid=2389b2109725e9dc075294dc44b7dc46'
    PARAMS={'units':'metric'}
    data = requests.get(url, params=PARAMS).json()
    description = data['weather'][0]['description']
    icon = data['weather'][0]['icon']
    temp = data['main']['temp']

    day = datetime.date.today()

    return render(request,'index.html',{'description':description,'icon':icon,'temp':temp,'day':day,'city':city})
