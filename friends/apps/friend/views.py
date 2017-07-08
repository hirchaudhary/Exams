from django.shortcuts import render, redirect
from .models import Users, Friend
from django.contrib import messages

def index(request):
    return render(request, 'friend/index.html')

def success(request):
    allusers = Users.userManager.exclude(id=request.session['id'])
    friends = Friend.objects.filter(sender_id=request.session['id'])
    for friend in friends:
        allusers = allusers.exclude(id=friend.reciever.id)
    no = ""
    if len(friends) < 1:
        no = "You have no Friends."
    context = {
        'nonfriend': allusers,
        'friends': friends,
        'no': no
    }
    return render(request, 'friend/success.html', context)

def registration(request):
    check = Users.userManager.registration(first_name=request.POST['first_name'], last_name=request.POST['last_name'], email=request.POST['email'], password=request.POST['password'], confirm_password=request.POST['confirm_password'], birthdate=request.POST['birthdate'])
    print request.POST['birthdate']
    if check[0]:
        messages.add_message(request, messages.SUCCESS, "You have successfully registerd!")
        request.session['id'] = check[1].id
        request.session['first_name'] = check[1].first_name
        return redirect('/success')
    else:
        for message in check[1]:
            messages.add_message(request, messages.ERROR, message)
        return redirect('/')
    return redirect('/')

def login(request):
    check = Users.userManager.login(email=request.POST['email'], password=request.POST['password'])

    if check[0]:
        messages.add_message(request, messages.SUCCESS, "You have successfully logged in!")
        request.session['id'] = check[1]
        request.session['first_name'] = check[2]
        return redirect('/success')
    else:
        for error in check[1]:
            messages.add_message(request, messages.ERROR, error)
        return redirect('/')
    return redirect('/')

def logout(request):
	request.session.clear()
	return redirect('/')

def profile(request, id):
    users = Users.userManager.filter(id=id)
    context = {
        'users': users
    }
    return render(request, 'friend/profile.html', context)

def addfriend(request, id):
    Friend.objects.create(sender_id=request.session['id'],reciever_id=id)
    Friend.objects.create(sender_id=id,reciever_id=request.session['id'])
    return redirect('/success')

def remove(request, id):
    friend = Friend.objects.filter(sender_id=request.session['id'], reciever_id=id).delete()
    friend = Friend.objects.filter(sender_id=id, reciever_id=request.session['id']).delete()
    return redirect('/success')
