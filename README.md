# lilycomment.vim

lilycomment is comment plugin for csharp.  
One day, I searched comment plugin. But the one is not in the net.  
So I made this. What I write in the other?  

## Requirement   

This plugin is used lambda function.  
YES! It's function was implemented in Vim 8.0.  
SO YOU NEED TO UPDATE VIM 8.0!

## Install  

PLZ use plugin-manager.
if you use NeoBundle,

```vim
Neobundle 'hananana/lilycomment.vim'
```

Oops, you love junegunn? Me to. vim-plug is cool.

```vim
Plug 'hananana/lilycomment.vim'
```

As you like.

## Commands  

:LilyComment

Insert Comment with tags.

### Example

```cs
///<summary>
///
///</summary>
public class Hoge
{
    ///<summary>
    ///
    ///</summary>
    ///<param name="foo"> </param>
    ///<param name="bar"> </param>
    ///<return> </return>
    string DoSomething(int foo, string bar)
    {

    }
}

```

