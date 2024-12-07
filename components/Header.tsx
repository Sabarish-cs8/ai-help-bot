import Avatar from './Avatar'
import Link from 'next/link'

function Header() {
  return (
    <header>
        <Link href="/">
        {/**Avartar */}
        <Avatar 
        seed='Heartbreak support Agent'
        />
        <div>
            <h1>Classic</h1>
            <h2 className='text-sm'>Your Customisable AI Chat Agent</h2>
        </div>
        </Link>
    </header>
  )
}

export default Header